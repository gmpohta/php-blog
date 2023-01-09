ARG PHP_VERSION

FROM php:${PHP_VERSION}-cli-alpine

ARG TIMEZONE
ARG COMPOSER_VERSION

RUN addgroup -g 1000 app && adduser -u 1000 -G app -s /bin/sh -D app

RUN apk update \
    && apk add ${PHPIZE_DEPS} curl git postgresql-dev zlib-dev bash-completion libzip-dev libxml2-dev make \
    freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev icu-dev \
    jpegoptim optipng  pcre-dev\
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && pecl clear-cache \
    && apk del ${PHPIZE_DEPS} libpng-dev libjpeg-turbo libjpeg-turbo-dev \
    && rm -frv /var/cache/apk/* \
    && curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/bin \
        --filename=composer  \
        --version=${COMPOSER_VERSION} \
    && chmod +x /usr/bin/composer

RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && sed -i "s/;date.timezone =.*/date.timezone = ${TIMEZONE}/g" /usr/local/etc/php/php.ini \
    && sed -i 's/memory_limit =.*/memory_limit = -1/g' /usr/local/etc/php/php.ini \
    && sed -i 's/max_execution_time =.*/max_execution_time = 30/g' /usr/local/etc/php/php.ini \
    && sed -i 's/max_input_time =.*/max_input_time = 60/g' /usr/local/etc/php/php.ini \
    && sed -i 's/post_max_size =.*/post_max_size = 24M/g' /usr/local/etc/php/php.ini \
    && sed -i 's/upload_max_filesize =.*/upload_max_filesize = 24M/g' /usr/local/etc/php/php.ini \
    && sed -i 's/variables_order =.*/variables_order = "EGPCS"/g' /usr/local/etc/php/php.ini \
    # [APCu] configuration
    && echo "apc.enable_cli=1" >> /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini \
    && echo "apc.shm_size=256M" >> /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini

USER app

WORKDIR /var/www/app
