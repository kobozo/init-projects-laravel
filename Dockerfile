FROM php:7.4-rc-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql
RUN addgroup --gid 1000 kobozo
RUN adduser -S kobozo -G kobozo -H -u 1000
RUN apk add composer

USER kobozo

WORKDIR /var/www/