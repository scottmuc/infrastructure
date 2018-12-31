
resource "aws_route53_zone" "scottmuc_work" {
  name = "scottmuc.work."
}

resource "aws_route53_record" "home_scottmuc_work" {
  zone_id = "${aws_route53_zone.scottmuc_work.zone_id}"
  name = "home.${aws_route53_zone.scottmuc_work.name}"
  type = "A"
  ttl = "7200"
  records = ["127.0.0.1"]
}