FROM php:fpm-alpine

RUN apk update && apk --no-cache add \
        freetype-dev \
        libjpeg-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        zlib-dev \
        libxml2-dev \
        libzip-dev \
        oniguruma-dev \
        graphviz \
        curl-dev \
        icu-dev \
        gettext \
        gettext-dev

RUN docker-php-ext-configure gd
RUN docker-php-ext-install pdo pdo_mysql tokenizer ctype json bcmath xml mbstring zip -j$(nproc) gd curl fileinfo gettext
RUN docker-php-source delete

#Add redis package
ENV REDIS_VERSION 5.3.1

RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$REDIS_VERSION.tar.gz && \
    tar xfz /tmp/redis.tar.gz && \
    rm -r /tmp/redis.tar.gz && \
    mkdir -p /usr/src/php/ext && \
    mv phpredis-* /usr/src/php/ext/redis && \
    docker-php-ext-install redis

#RUN a2enmod rewrite
#RUN service apache2 restart

#RUN apt install php7-xml php7-mbstring #php7-tokenizer php7-ctype php7-json php7-bcmath
RUN addgroup --gid 1000 yannick && \
    adduser -S yannick -G yannick -u 1000 && \
    mkdir /home/yannick/.composer && \
    chown yannick: /home/yannick/.composer
RUN apk --no-cache add composer

ENV WAIT_VERSION 2.7.3
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/$WAIT_VERSION/wait /wait
RUN chmod +x /wait

#RUN apk cache clean
USER yannick


WORKDIR /var/www/