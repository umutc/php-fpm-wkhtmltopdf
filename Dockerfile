FROM nginx:latest

MAINTAINER Umut ÇELİK <mail@umutcelik.com.tr>

RUN apt-get update && apt-get upgrade -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpq-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libmcrypt-dev \
    libpng12-dev \
    libmemcached-dev \
    libssl-dev \
    libssl-doc \
    libsasl2-dev \
    zlib1g-dev \
    libicu-dev \
    g++ \
    && docker-php-ext-install \
        bz2 \
        iconv \
        mbstring \
        mcrypt \
        mysqli \
        pgsql \
        pdo_mysql \
        pdo_pgsql \
        soap \
        zip \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-configure intl  \
    && docker-php-ext-install intl \
    && pecl install xdebug && docker-php-ext-enable xdebug \
    && pecl install mongodb && docker-php-ext-enable mongodb \
    && pecl install redis && docker-php-ext-enable redis \
    && yes '' | pecl install imagick && docker-php-ext-enable imagick

RUN apt-get update \
    && apt-get install -y \
        curl \
        libxrender1 \
        libfontconfig \
        libxtst6 \
        xz-utils

RUN curl "https://downloads.wkhtmltopdf.org/0.12/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz" -L -o "wkhtmltopdf.tar.xz"
RUN tar Jxvf wkhtmltopdf.tar.xz
RUN mv wkhtmltox/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf