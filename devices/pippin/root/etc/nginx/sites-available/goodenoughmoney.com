server {
    server_name www.goodenoughmoney.com;

    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/www.goodenoughmoney.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/www.goodenoughmoney.com/privkey.pem;

    index index.html index.htm;
    root /opt/goodenoughmoney.com;
}

server {
    server_name www.goodenoughmoney.com goodenoughmoney.com;

    listen 80;

    location / {
      return 301 https://www.goodenoughmoney.com$request_uri;
    }
}
