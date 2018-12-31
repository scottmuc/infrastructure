
resource "aws_route53_zone" "mucmail_com" {
  name = "mucmail.com."
}


resource "aws_route53_record" "mx-mucmail_com" {
  zone_id = "${aws_route53_zone.mucmail_com.zone_id}"
  name = "${aws_route53_zone.mucmail_com.name}"
  type = "MX"
  ttl = "28800"
  records = [
    "1 ASPMX.L.GOOGLE.COM.",
    "3 ALT1.ASPMX.L.GOOGLE.COM.",
    "3 ALT2.ASPMX.L.GOOGLE.COM.",
    "5 ASPMX2.GOOGLEMAIL.COM.",
    "5 ASPMX3.GOOGLEMAIL.COM.",
    "5 ASPMX4.GOOGLEMAIL.COM",
    "5 ASPMX5.GOOGLEMAIL.COM."
  ]
}