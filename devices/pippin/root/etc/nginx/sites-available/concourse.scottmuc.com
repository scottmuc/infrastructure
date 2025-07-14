server {
    server_name concourse.scottmuc.com;

    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/concourse.scottmuc.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/concourse.scottmuc.com/privkey.pem;

    add_header Strict-Transport-Security "max-age=31536000" always;
    ssl_stapling on;
    ssl_stapling_verify on;

    # Proxy main concourse traffic
    location / {
        proxy_pass http://merry:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Protocol $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
    }

    # Proxy fly intercept traffic
    location ~ /hijack$ {
        proxy_pass http://merry:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Protocol $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        # Upgrade connection
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}


server {
    server_name concourse.scottmuc.com;

    listen 80;

    location / {
      return 301 https://concourse.scottmuc.com$request_uri;
    }
}
