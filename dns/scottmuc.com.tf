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


resource "gandi_zonerecord" "txt_scottmuc_com" {
  zone = data.gandi_zone.scottmuc_com.id
  name = "@"
  type = "TXT"
  ttl = "3600"
  values = [
    "keybase-site-verification=WYe5ju0VjNIRHhBkHg6s_ERw-CQBJ_LKq6zwfMDO5Wk"
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
    "192.168.2.10"
  ]
}


resource "gandi_domainattachment" "scotttmuc_com" {
  zone   = data.gandi_zone.scottmuc_com.id
  domain = "scottmuc.com"
}
