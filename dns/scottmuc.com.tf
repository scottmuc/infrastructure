variable "home_ip" {
}


resource "aws_route53_zone" "scottmuc_com" {
  name = "scottmuc.com."
}


data "gandi_zone" "scottmuc_com" {
  name = "scottmuc.com"
}


resource "aws_route53_record" "scottmuc_com" {
  zone_id = aws_route53_zone.scottmuc_com.zone_id
  name = aws_route53_zone.scottmuc_com.name
  type = "A"
  ttl = "3600"
  records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153"
  ]
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


resource "aws_route53_record" "mx-scottmuc_com" {
  zone_id = aws_route53_zone.scottmuc_com.zone_id
  name = aws_route53_zone.scottmuc_com.name
  type = "MX"
  ttl = "3600"
  records = [
    "90 aspmx2.google.com.",
    "90 aspmx3.google.com.",
    "50 alt1.aspmx.l.google.com.",
    "10 aspmx.l.google.com.",
    "50 alt2.aspmx.l.google.com.",
    "90 aspmx4.google.com.",
    "90 aspmx5.google.com."
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


resource "aws_route53_record" "www_scottmuc_com" {
  zone_id = aws_route53_zone.scottmuc_com.zone_id
  name = "www.${aws_route53_zone.scottmuc_com.name}"
  type = "CNAME"
  ttl = "3600"
  records = ["scottmuc.com."]
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

resource "aws_route53_record" "feeds_scottmuc_com" {
  zone_id = aws_route53_zone.scottmuc_com.zone_id
  name = "feeds.${aws_route53_zone.scottmuc_com.name}"
  type = "CNAME"
  ttl = "3600"
  records = ["18y3nfm.feedproxy.ghs.google.com."]
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


resource "aws_route53_record" "mail_scottmuc_com" {
  zone_id = aws_route53_zone.scottmuc_com.zone_id
  name = "mail.${aws_route53_zone.scottmuc_com.name}"
  type = "CNAME"
  ttl = "3600"
  records = ["ghs.google.com."]
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



resource "gandi_domainattachment" "scotttmuc_com" {
  zone   = data.gandi_zone.scottmuc_com.id
  domain = "scottmuc.com"
}
