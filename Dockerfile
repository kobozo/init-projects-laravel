FROM php:7.4-rc-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql
RUN addgroup --gid 1000 kobozo && \
    adduser -S kobozo -G kobozo -u 1000 && \
    mkdir /home/kobozo/.composer && \
    chown kobozo: /home/kobozo/.composer
RUN apk add composer

USER kobozo

WORKDIR /var/www/