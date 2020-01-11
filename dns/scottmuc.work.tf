data "gandi_zone" "scottmuc_work" {
  name = "scottmuc.work"
}

resource "gandi_zonerecord" "at_scottmuc_work" {
  zone = data.gandi_zone.scottmuc_work.id
  name = "@"
  type = "A"
  ttl = 3600
  values = [
    "192.168.0.1"
  ]
}


resource "gandi_zonerecord" "foo_scottmuc_work" {
  zone = data.gandi_zone.scottmuc_work.id
  name = "foo"
  type = "A"
  ttl = 3600
  values = [
    "192.168.0.1"
  ]
}

resource "gandi_zonerecord" "mx_scottmuc_work" {
  zone = data.gandi_zone.scottmuc_work.id
  name = "@"
  type = "MX"
  ttl = 3600
  values = [
    "10 foo.mx.mail",
    "50 foo.mx.mail",
  ]
}

resource "gandi_domainattachment" "scotttmuc_work" {
  zone   = data.gandi_zone.scottmuc_work.id
  domain = "scottmuc.work"
}
