data "gandi_zone" "goodenoughmoney_com" {
  name = "goodenoughmoney.com"
}


resource "gandi_zonerecord" "at_goodenoughmoney_com" {
  zone = data.gandi_zone.goodenoughmoney_com.id
  name = "@"
  type = "A"
  ttl = "3600"
  values = [
    var.home_ip
  ]
}


resource "gandi_zonerecord" "www_goodenoughmoney_com" {
  zone = data.gandi_zone.goodenoughmoney_com.id
  name = "www"
  type = "A"
  ttl = "3600"
  values = [
    var.home_ip
  ]
}


resource "gandi_domainattachment" "goodenoughmoney_com" {
  zone   = data.gandi_zone.goodenoughmoney_com.id
  domain = "goodenoughmoney.com"
}
