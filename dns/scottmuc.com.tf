variable "home_ip" {
}


data "gandi_zone" "scottmuc_com" {
  name = "scottmuc.com"
}


resource "gandi_zonerecord" "at_scottmuc_com" {
  zone = data.gandi_zone.scottmuc_com.id
  name = "@"
  type = "A"
  ttl = "3600"
  values = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153"
  ]
}


resource "gandi_zonerecord" "mx_at_scottmuc_com" {
  zone = data.gandi_zone.scottmuc_com.id
  name = "@"
  type = "MX"
  ttl = "3600"
  values = [
    "90 aspmx2.google.com.",
    "90 aspmx3.google.com.",
    "50 alt1.aspmx.l.google.com.",
    "10 aspmx.l.google.com.",
    "50 alt2.aspmx.l.google.com.",
    "90 aspmx4.google.com.",
    "90 aspmx5.google.com."
  ]
}


resource "gandi_zonerecord" "www_scottmuc_com" {
  zone = data.gandi_zone.scottmuc_com.id
  name = "www"
  type = "CNAME"
  ttl = "3600"
  values = [
    "scottmuc.com."
  ]
}

resource "gandi_zonerecord" "feeds_scottmuc_com" {
  zone = data.gandi_zone.scottmuc_com.id
  name = "feeds"
  type = "CNAME"
  ttl = "3600"
  values = [
    "18y3nfm.feedproxy.ghs.google.com."
  ]
}


resource "gandi_zonerecord" "mail_scottmuc_com" {
  zone = data.gandi_zone.scottmuc_com.id
  name = "mail"
  type = "CNAME"
  ttl = "3600"
  values = [
    "ghs.google.com."
  ]
}


resource "gandi_zonerecord" "home_scottmuc_com" {
  zone = data.gandi_zone.scottmuc_com.id
  name = "home"
  type = "A"
  ttl = "3600"
  values = [
    var.home_ip
  ]
}

resource "gandi_zonerecord" "pi_home_scottmuc_com" {
  zone = data.gandi_zone.scottmuc_com.id
  name = "pi.home"
  type = "A"
  ttl = "3600"
  values = [
    "192.168.2.111"
  ]
}


resource "gandi_domainattachment" "scotttmuc_com" {
  zone   = data.gandi_zone.scottmuc_com.id
  domain = "scottmuc.com"
}
