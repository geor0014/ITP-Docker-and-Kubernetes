FROM nginx:stable-alpine

WORKDIR /ect/nginx/conf.d

COPY nginx/28349543-nginx.conf .

RUN mv 28349543-nginx.conf default.conf

WORKDIR /var/www/html

COPY src . 