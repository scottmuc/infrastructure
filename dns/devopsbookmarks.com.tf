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

resource "gandi_livedns_record" "ipv6_at_devopsbookmarks_com" {
  zone = data.gandi_domain.devopsbookmarks_com.id
  name = "@"
  type = "AAAA"
  ttl = "3600"
  values = [
    "2a09:8280:1::1:a2dd"
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

resource "gandi_livedns_record" "acme_devopsbookmarks_com" {
  zone = data.gandi_domain.devopsbookmarks_com.id
  name = "_acme-challenge"
  type = "CNAME"
  ttl = "3600"
  values = [
    "devopsbookmarks.com.wdzm32.flydns.net."
  ]
}
