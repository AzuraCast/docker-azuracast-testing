FROM php:7.4-cli-alpine

RUN apk add --no-cache zip git curl npm mysql-client

RUN apk add --no-cache icu-dev freetype-dev libjpeg-turbo-dev libpng-dev \
    && docker-php-ext-install gmp \
    && docker-php-ext-install intl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install pdo_mysql

RUN apk add --no-cache --virtual .build-deps autoconf build-base \
    && pecl install redis-5.1.1 \
    && pecl install xdebug-2.8.1 \
    && docker-php-ext-enable redis xdebug \
    && apk del .build-deps

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN mkdir /app
WORKDIR /app

CMD ["composer", "test"]