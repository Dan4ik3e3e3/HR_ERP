# Create required directories
New-Item -ItemType Directory -Force -Path "nginx/ssl"
New-Item -ItemType Directory -Force -Path "nginx/www"
New-Item -ItemType Directory -Force -Path "nginx/conf.d"

# Create temporary Nginx configuration for SSL certificates
@"
server {
    listen 80;
    server_name hr-erp.ru www.hr-erp.ru;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        return 301 https://`$host`$request_uri;
    }
}
"@ | Out-File -FilePath "nginx/conf.d/default.conf" -Encoding UTF8

# Start Nginx
docker compose up -d nginx

# Get SSL certificates
docker compose run --rm certbot

# Remove temporary configuration
Remove-Item -Path "nginx/conf.d/default.conf" -Force

# Restart Nginx with main configuration
docker compose restart nginx

Write-Host "SSL certificates initialized successfully!" -ForegroundColor Green 