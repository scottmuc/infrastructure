
resource "aws_route53_zone" "pesterbdd_com" {
  name = "pesterbdd.com."
}


resource "aws_route53_record" "pesterbdd_com" {
  zone_id = "${aws_route53_zone.pesterbdd_com.zone_id}"
  name = "${aws_route53_zone.pesterbdd_com.name}"
  type = "A"
  ttl = "3600"
  records = [
    "192.30.252.153",
    "192.30.252.154"
  ]
}


resource "aws_route53_record" "www_pesterbdd_com" {
  zone_id = "${aws_route53_zone.pesterbdd_com.zone_id}"
  name = "www.${aws_route53_zone.pesterbdd_com.name}"
  type = "CNAME"
  ttl = "3600"
  records = ["pesterbdd.com."]
}

