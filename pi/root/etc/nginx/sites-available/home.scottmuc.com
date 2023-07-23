# Much of this is taken from the Grafana docs and I need to dig a bit deeper
# to fully understand all the changes:
# https://grafana.com/tutorials/run-grafana-behind-a-proxy/
map $http_upgrade $connection_upgrade {
  default upgrade;
  '' close;
}

upstream grafana {
  server pi.home.scottmuc.com:3000;
}

server {
    server_name home.scottmuc.com;

    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/home.scottmuc.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/home.scottmuc.com/privkey.pem;

    location /music/ {
        proxy_pass http://pi.home.scottmuc.com:4533;
    }

    location /prometheus/ {
        proxy_pass http://pi.home.scottmuc.com:9090;
    }

    location /grafana/ {
        proxy_set_header Host $http_host;
        proxy_pass http://grafana;
    }

    # Proxy Grafana Live WebSocket connections.
    location /grafana/api/live/ {
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        proxy_set_header Host $http_host;
        proxy_pass http://grafana;
    }
}

server {
    server_name home.scottmuc.com;

    listen 80;

    location / {
      return 301 https://home.scottmuc.com$request_uri;
    }
}
