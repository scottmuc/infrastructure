server {
    server_name zot.scottmuc.com;

    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/zot.scottmuc.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/zot.scottmuc.com/privkey.pem;

    client_max_body_size 0;
    proxy_request_buffering off;

    location / {
        proxy_pass http://merry:8081/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;

        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Protocol $scheme;

        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;

        # Handle large uploads (container images)
        proxy_read_timeout 900;
        proxy_connect_timeout 900;
        proxy_send_timeout 900;

        # Don't buffer responses (streaming)
        proxy_buffering off;
    }
}


server {
    server_name zot.scottmuc.com;

    listen 80;

    location / {
      return 301 https://zot.scottmuc.com$request_uri;
    }
}
