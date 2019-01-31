FROM alpine:3.9

RUN apk add --no-cache zip git curl php7-cli \
    php7-mbstring php7-phar php7-openssl php7-fileinfo php7-gd php7-intl \
    php7-simplexml php7-xml php7-xmlwriter php7-json php7-redis php7-pdo \
    php7-xdebug

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN mkdir /app
WORKDIR /app

CMD ["composer", "test"]