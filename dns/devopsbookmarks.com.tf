data "gandi_domain" "devopsbookmarks_com" {
  name = "devopsbookmarks.com"
}


resource "gandi_livedns_record" "at_devopsbookmarks_com" {
  zone = data.gandi_domain.devopsbookmarks_com.id
  name = "@"
  type = "A"
  ttl = "3600"
  values = [
    "149.248.210.13"
  ]
}


resource "gandi_livedns_record" "www_devopsbookmarks_com" {
  zone = data.gandi_domain.devopsbookmarks_com.id
  name = "www"
  type = "CNAME"
  ttl = "3600"
  values = [
    "devopsbookmarks.fly.dev"
  ]
}
