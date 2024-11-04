FROM php:8.3-fpm

RUN apt-get update && apt-get install -y wget bash nano coreutils libc-client-dev libkrb5-dev libpng-dev libsodium-dev libgmp-dev libzip-dev libargon2-dev libxml2-dev iputils-ping libpq-dev wget curl && rm -r /var/lib/apt/lists/*
RUN docker-php-ext-install mysqli pdo pdo_mysql gd bcmath gmp xml zip sodium soap pgsql pdo_pgsql
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && docker-php-ext-install imap
RUN pecl install xdebug && docker-php-ext-enable xdebug 
RUN pecl install redis && docker-php-ext-enable redis

ADD "php.ini" "$PHP_INI_DIR/php.ini"
ADD "debug.ini" "$PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini"

RUN chmod 0744 "$PHP_INI_DIR/php.ini" "$PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini"
