data "gandi_zone" "scottmuc_work" {
  name = "scottmuc.work"
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

