server {
    server_name www.goodenoughmoney.com;

    listen 443 ssl;
    # Installation command:
    # certbot certonly --webroot -w /var/www/html -d www.goodenoughmoney.com -m "scottmuc@gmail.com"
    ssl_certificate /etc/letsencrypt/live/www.goodenoughmoney.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/www.goodenoughmoney.com/privkey.pem;

    index index.html index.htm;
    root /opt/goodenoughmoney;
}

server {
    server_name www.goodenoughmoney.com goodenoughmoney.com;

    listen 80;

    location /.well-known/acme-challenge/ {
      default_type "text/plain";
      root /var/www/html;
      try_files $uri =404;
    }

    location / {
      return 301 https://www.goodenoughmoney.com$request_uri;
    }
}
