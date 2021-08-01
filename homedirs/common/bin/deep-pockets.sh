#!/usr/bin/env bash

set -e
set -o pipefail

[[ -z "${DEBUG}" ]] || set -x

CACHE_DIR="${HOME}/.config/deep-pockets"
SYNCED_JSON_DATA="${CACHE_DIR}/data.json"

main() {
  local sub_command
  sub_command="$1"
  case "$sub_command" in
    sync)
      sync
      ;;
    stats)
      display_stats
      ;;
    posts-by-tag)
      tag="$2"
      posts_by_tag "${tag}"
      ;;
    reading-time-csv)
      reading_time_csv
      ;;
    tags-csv)
      tags_csv
      ;;
    *)
      print_usage_and_exit
      ;;
  esac
}

print_usage_and_exit() {
  cat <<HELP
usage: $0 <command>

Deep understanding of getpocket.com data

Commands:
 - sync
     synchronize data locally with what's on getpocket.com

 - stats
     displays some stats of the whole dataset

 - posts-by-tag <tag>
     lists the urls of articles associated with a tag

 - reading-time-csv
     lists all read articles over time

 - tags-csv
     lists all read articles by tag
HELP

  exit 1
}

# TODO extract a function to compute the median time to read (currently it's 7)
# TODO create separate script that makes it easy to pipe csv into Google Sheets

reading_time_csv() {
# TODO figure out why .time_read is sometimes 0 for read articles
  echo "timestamp,reading_time,work_related_reading_time"
  read_articles \
    | jq -r "(if (.time_to_read | length) == 0 then 7 else .time_to_read end) as \$time_to_read |
             (if (.tags | length) == 0 then false else (.tags.\"work-related\" != null) end) as \$work_related |
               [
                 .time_read,
                 if (\$work_related) then 0 else \$time_to_read end,
                 if (\$work_related) then \$time_to_read else 0 end
	             ] | @csv"
}

tags_csv() {
# TODO this should all be based off of read_articles
  # This now outputs a per article:tag pair. So if an article has 2 tags, 3 rows will
  # be printed
  #
  # This is because of the addition of the "tagged" tag. This allows datastudio to ignore
  # the repeated articles by creating a filter that UNIONs all "tagged" and "untagged" articles.
  # The other rows can then be used to break things down more (hopefully)
  echo "timestamp,reading_time,tag"
  tagged \
    | jq -r "(if (.time_to_read | length) == 0 then 7 else .time_to_read end) as \$time_to_read |
            [  .time_read,
               \$time_to_read,
               \"tagged\"
             ] | @csv"

  tagged \
    | jq -r "(if (.time_to_read | length) == 0 then 7 else .time_to_read end) as \$time_to_read |
              .time_read as \$time_read |
              .tags | to_entries[] |
            [  \$time_read,
               \$time_to_read,
               .key
             ] | @csv"

  untagged \
    | jq -r "(if (.time_to_read | length) == 0 then 7 else .time_to_read end) as \$time_to_read |
            [  .time_read,
               \$time_to_read,
               \"untagged\"
             ] | @csv"
}

posts_by_tag() {
  local tag="$1"
  tagged | jq -r ". | select(.tags[].tag == \"${tag}\") | .given_url"
}

work_related() {
  tagged | jq '. | select(.tags[].tag == "work-related")'
}

tagged() {
  read_articles | jq "select(.tags != null)"
}

untagged() {
  read_articles | jq "select(.tags == null)"
}

read_articles() {
  all | jq 'select(.is_article == "1") | select(.status = "1")'
}

all() {
  jq ".list[]" "${SYNCED_JSON_DATA}"
}


display_stats() {
  total_count=$(all | jq '.item_id' | wc -l)
  tagged_count=$(tagged | jq .item_id | wc -l)
  work_related_count=$(work_related | jq .item_id | wc -l)
  unread_count=$(all | jq -r 'select(.status == "0") | .item_id' | wc -l)
  reading_time=$(all | jq -r '.time_to_read' | paste -sd+ - | bc)
  work_related_reading_time=$(work_related | jq -r .time_to_read | paste -sd+ - | bc)
  tag_counts=$(tagged | jq -r .tags[].tag \
    | sort \
    | uniq -c \
    | sort -nr)

  cat <<STATS
article count              : ${total_count}
articles unread            : ${unread_count}
articles tagged            : ${tagged_count}
articles work related      : ${work_related_count}
reading time (work related): ${work_related_reading_time}m
reading time               : ${reading_time}m
tag counts                 :
${tag_counts}
STATS

}

sync() {
  local redirect_url consumer_key

  mkdir -p "${CACHE_DIR}"

  # this jq query is an example of what makes the 1password CLI hard to work with
  # it is also coupling to my personal preference for a password manager
  consumer_key=$(op get item "deep-pockets" | \
    jq -r '.details.sections[] |select(.fields)| .fields[] | select(.t == "consumer-key") | .v')

  # stub webserver to handle browser redirect from getpocket.com
  redirect_url="http://localhost:1500/"

  request_code=$(curl \
    https://getpocket.com/v3/oauth/request 2>/dev/null \
    -X POST \
    -H "Content-Type: application/json; charset=UTF-8" \
    -H "X-Accept: application/json" \
    -d @- <<JSON |
{
  "consumer_key":"${consumer_key}",
  "redirect_uri":"${redirect_url}"
}
JSON
    jq -r .code)

  echo "Need to request a token, please open the following URL in your browser:

  https://getpocket.com/auth/authorize?request_token=${request_code}&redirect_uri=${redirect_url}
"

  nc -l localhost 1500 >/dev/null < <(echo -e "HTTP/1.1 200 OK\n\n $(date)")

  echo "Fetching data..."

  access_token=$(curl \
    https://getpocket.com/v3/oauth/authorize 2>/dev/null \
    -X POST \
    -H "Content-Type: application/json; charset=UTF-8" \
    -H "X-Accept: application/json" \
    -d @- <<JSON |
{
  "consumer_key":"${consumer_key}",
  "code":"${request_code}"
}
JSON
    jq -r .access_token)


  # interesting thing about `read` is that it doesn't exit 0 when successful
  # so that's why the trailing `true`
  read -r -d '' req_json <<FOO ||
{
  "consumer_key":"${consumer_key}",
  "access_token":"${access_token}",
  "state":"all",
  "detailType":"complete"
}
FOO
  true

  # There is 1 single endpoint for retrieval of date from pocket. Everything
  # you need to know is here: https://getpocket.com/developer/docs/v3/retrieve
  curl \
    https://getpocket.com/v3/get 2>/dev/null \
    -o "${SYNCED_JSON_DATA}" \
    -X POST \
    -H "Content-Type: application/json" \
    -d "${req_json}"

  echo Data synchronized!
}

main "$@"
