#!/bin/bash

# Создаем необходимые директории
mkdir -p nginx/ssl
mkdir -p nginx/www
mkdir -p nginx/conf.d

# Создаем временную конфигурацию Nginx для получения сертификатов
cat > nginx/conf.d/default.conf << 'EOL'
server {
    listen 80;
    server_name hr-erp.ru www.hr-erp.ru;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        return 301 https://$host$request_uri;
    }
}
EOL

# Запускаем Nginx
docker-compose up -d nginx

# Получаем SSL-сертификаты
docker-compose run --rm certbot

# Удаляем временную конфигурацию
rm nginx/conf.d/default.conf

# Перезапускаем Nginx с основной конфигурацией
docker-compose restart nginx

echo "SSL-сертификаты успешно инициализированы!" 