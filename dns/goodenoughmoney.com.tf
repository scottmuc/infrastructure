data "gandi_domain" "goodenoughmoney_com" {
  name = "goodenoughmoney.com"
}


resource "gandi_livedns_record" "at_goodenoughmoney_com" {
  zone = data.gandi_domain.goodenoughmoney_com.id
  name = "@"
  type = "A"
  ttl  = "3600"
  values = [
    var.home_ip
  ]
}


resource "gandi_livedns_record" "www_goodenoughmoney_com" {
  zone = data.gandi_domain.goodenoughmoney_com.id
  name = "www"
  type = "A"
  ttl  = "3600"
  values = [
    var.home_ip
  ]
}
