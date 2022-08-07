server {
    server_name home.scottmuc.com;

    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/home.scottmuc.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/home.scottmuc.com/privkey.pem;

    # TODO
    # Figure out how to place these location rules closer to the ansible code
    # that defines the services running on these ports.
    location /music/ {
        proxy_pass http://pi.home.scottmuc.com:4533;
    }

    location /prometheus/ {
        proxy_pass http://pi.home.scottmuc.com:9090;
    }

    location /grafana/ {
        proxy_pass http://pi.home.scottmuc.com:3000;
    }
}

server {
    server_name home.scottmuc.com;

    listen 80;

    location / {
      return 301 https://home.scottmuc.com$request_uri;
    }
}
