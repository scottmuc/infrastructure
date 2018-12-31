
resource "aws_route53_zone" "devopsbookmarks_com" {
  name = "devopsbookmarks.com."
}

resource "aws_route53_record" "devopsbookmarks_com" {
  zone_id = "${aws_route53_zone.devopsbookmarks_com.zone_id}"
  name = "${aws_route53_zone.devopsbookmarks_com.name}"
  type = "A"
  ttl = "10800"
  records = ["217.70.184.38"]
}

resource "aws_route53_record" "www_devopsbookmarks_com" {
  zone_id = "${aws_route53_zone.devopsbookmarks_com.zone_id}"
  name = "www.${aws_route53_zone.devopsbookmarks_com.name}"
  type = "CNAME"
  ttl = "10800"
  records = ["devops-bookmarks.herokuapp.com"]
}