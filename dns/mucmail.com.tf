data "gandi_domain" "mucmail_com" {
  name = "mucmail.com"
}


resource "gandi_livedns_record" "mx_at_mucmail_com" {
  zone = data.gandi_domain.mucmail_com.id
  name = "@"
  type = "MX"
  ttl = "3600"
  values = [
    "1 ASPMX.L.GOOGLE.COM.",
    "3 ALT1.ASPMX.L.GOOGLE.COM.",
    "3 ALT2.ASPMX.L.GOOGLE.COM.",
    "5 ASPMX2.GOOGLEMAIL.COM.",
    "5 ASPMX3.GOOGLEMAIL.COM.",
    "5 ASPMX4.GOOGLEMAIL.COM",
    "5 ASPMX5.GOOGLEMAIL.COM."
  ]
}
