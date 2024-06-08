server {
    server_name home.scottmuc.com;

    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/home.scottmuc.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/home.scottmuc.com/privkey.pem;

    location /music/ {
        proxy_pass http://192.168.2.10:4533;
    }

    index index.html;
    root /opt/home.scottmuc.com;
}

server {
    server_name home.scottmuc.com;

    listen 80;

    location / {
      return 301 https://home.scottmuc.com$request_uri;
    }
}
