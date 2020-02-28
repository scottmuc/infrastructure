data "gandi_zone" "devopsbookmarks_com" {
  name = "devopsbookmarks.com"
}


resource "gandi_zonerecord" "at_devopsbookmarks_com" {
  zone = data.gandi_zone.devopsbookmarks_com.id
  name = "@"
  type = "A"
  ttl = "3600"
  values = [
    "217.70.184.38"
  ]
}


resource "gandi_zonerecord" "www_devopsbookmarks_com" {
  zone = data.gandi_zone.devopsbookmarks_com.id
  name = "www"
  type = "CNAME"
  ttl = "3600"
  values = [
    "devops-bookmarks.herokuapp.com."
  ]
}


resource "gandi_domainattachment" "devopsbookmarks_com" {
  zone   = data.gandi_zone.devopsbookmarks_com.id
  domain = "devopsbookmarks.com"
}
