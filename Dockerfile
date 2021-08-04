FROM php:8.0-cli-alpine

RUN apk add --no-cache zip git curl npm mysql-client python3 make g++ bash

RUN apk add --no-cache gmp-dev icu-dev freetype-dev libjpeg-turbo-dev libpng-dev \
    && docker-php-ext-install gmp \
    && docker-php-ext-install intl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install pdo_mysql

RUN apk add --no-cache --virtual .build-deps autoconf build-base \
    && pecl install redis-5.3.4 \
    && pecl install xdebug-3.0.4 \
    && docker-php-ext-enable redis xdebug \
    && apk del .build-deps

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN mkdir /app
WORKDIR /app

CMD ["composer", "test"]