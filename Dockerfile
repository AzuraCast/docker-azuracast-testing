FROM php:8.1-cli-alpine

RUN apk add --no-cache zip git curl npm mysql-client python3 make g++ bash

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions @composer gmp intl gd pdo_mysql redis xdebug

RUN mkdir /app
WORKDIR /app

CMD ["composer", "test"]
