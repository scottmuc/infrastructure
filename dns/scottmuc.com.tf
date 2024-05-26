data "gandi_domain" "scottmuc_com" {
  name = "scottmuc.com"
}


resource "gandi_livedns_record" "at_scottmuc_com" {
  zone = data.gandi_domain.scottmuc_com.id
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


resource "gandi_livedns_record" "txt_scottmuc_com" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "@"
  type = "TXT"
  ttl = "3600"
  values = [
    "\"keybase-site-verification=WYe5ju0VjNIRHhBkHg6s_ERw-CQBJ_LKq6zwfMDO5Wk\"",
    "\"protonmail-verification=18a56110687f875948252dca450d300f0b9dd2e6\"",
    "\"v=spf1 include:_spf.protonmail.ch mx ~all\""
  ]
}


resource "gandi_livedns_record" "dmafc_scottmuc_com" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "_dmafc"
  type = "TXT"
  ttl = "3600"
  values = [
    "\"v=DMARC1; p=none; rua=mailto:scott@scottmuc.com\""
  ]
}


resource "gandi_livedns_record" "mx_at_scottmuc_com" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "@"
  type = "MX"
  ttl = "3600"
  values = [
    "10 mail.protonmail.ch.",
    "20 mailsec.protonmail.ch."
  ]
}


resource "gandi_livedns_record" "protonmail_domainkey" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "protonmail._domainkey"
  type = "CNAME"
  ttl = "3600"
  values = [
    "protonmail._domainkey.d5vyhyqcfvl4w4haoex2s3irbb6lx4r5xjqanoiwt2ppoguay27za.domains.proton.ch."
  ]
}


resource "gandi_livedns_record" "protonmail2_domainkey" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "protonmail2._domainkey"
  type = "CNAME"
  ttl = "3600"
  values = [
    "protonmail2._domainkey.d5vyhyqcfvl4w4haoex2s3irbb6lx4r5xjqanoiwt2ppoguay27za.domains.proton.ch."
  ]
}


resource "gandi_livedns_record" "protonmail3_domainkey" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "protonmail3._domainkey"
  type = "CNAME"
  ttl = "3600"
  values = [
    "protonmail3._domainkey.d5vyhyqcfvl4w4haoex2s3irbb6lx4r5xjqanoiwt2ppoguay27za.domains.proton.ch."
  ]
}


resource "gandi_livedns_record" "www_scottmuc_com" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "www"
  type = "CNAME"
  ttl = "3600"
  values = [
    "scottmuc.com."
  ]
}


resource "gandi_livedns_record" "feeds_scottmuc_com" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "feeds"
  type = "CNAME"
  ttl = "3600"
  values = [
    "18y3nfm.feedproxy.ghs.google.com."
  ]
}


resource "gandi_livedns_record" "home_scottmuc_com" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "home"
  type = "A"
  ttl = "3600"
  values = [
    var.home_ip
  ]
}


resource "gandi_livedns_record" "git_scottmuc_com" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "git"
  type = "A"
  ttl = "3600"
  values = [
    var.home_ip
  ]
}


resource "gandi_livedns_record" "concourse_home_scottmuc_com" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "concourse.home"
  type = "A"
  ttl = "3600"
  values = [
    "192.168.2.11"
  ]
}


resource "gandi_livedns_record" "pi_home_scottmuc_com" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "pi.home"
  type = "A"
  ttl = "3600"
  values = [
    "192.168.2.10"
  ]
}


resource "gandi_livedns_record" "prometheus_home_scottmuc_com" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "prometheus.home"
  type = "A"
  ttl = "3600"
  values = [
    "192.168.2.10"
  ]
}


resource "gandi_livedns_record" "grafana_home_scottmuc_com" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "grafana.home"
  type = "A"
  ttl = "3600"
  values = [
    "192.168.2.10"
  ]
}


resource "gandi_livedns_record" "graffiti_scottmuc_com" {
  zone = data.gandi_domain.scottmuc_com.id
  name = "graffiti"
  type = "TXT"
  ttl = "3600"
  values = [
    "\"Cleaned up the historic graffiti\"",
  ]
}
