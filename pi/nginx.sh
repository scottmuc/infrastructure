#!/usr/bin/env bash

set -e

apt-get install nginx certbot
certbot certonly --webroot -w /var/www/html -d home.scottmuc.com -m "scottmuc@gmail.com"

"
server {
    index index.html index.htm index.nginx-debian.html;
    server_name home.scottmuc.com;

    location /music/ {
        proxy_pass http://pi.home.scottmuc.com:4533;
    }

    listen [::]:443 ssl ipv6only=on;
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/home.scottmuc.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/home.scottmuc.com/privkey.pem;
}

server {
    if ($host = home.scottmuc.com) {
        return 301 https://$host$request_uri;
    }

    listen 80 ;
    listen [::]:80 ;
    server_name home.scottmuc.com;
    return 404;
}
"
