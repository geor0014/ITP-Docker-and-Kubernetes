FROM php:8.0.9-fpm-alpine3.14

WORKDIR /var/www/html

COPY src .

RUN docker-php-ext-install pdo pdo_mysql