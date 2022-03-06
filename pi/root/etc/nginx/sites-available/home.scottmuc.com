server {
    server_name home.scottmuc.com;

    listen 443 ssl;
    # Installation command:
    # certbot certonly --webroot /var/www/html -d home.scottmuc.com -m "scottmuc@gmail.com"
    ssl_certificate /etc/letsencrypt/live/home.scottmuc.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/home.scottmuc.com/privkey.pem;

    # proxy requests to navidrome
    location /music/ {
        proxy_pass http://pi.home.scottmuc.com:4533;
    }
}

server {
    server_name home.scottmuc.com;

    listen 80;

    location /.well-known/acme-challenge/ {
      default_type "text/plain";
      root /var/www/html;
      try_files $uri =404;
    }

    location / {
      return 301 https://home.scottmuc.com$request_uri;
    }
}
