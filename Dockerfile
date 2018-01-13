FROM php:7.1.11-fpm

MAINTAINER Umut ÇELİK <mail@umutcelik.com.tr>

RUN apt-get update && apt-get upgrade -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpq-dev \
    libmagickwand-dev \
    libpng12-dev \
    libmemcached-dev \
    libssl-dev \
    libssl-doc \
    libsasl2-dev \
    zlib1g-dev \
    libicu-dev \
    g++ \
    && docker-php-ext-install \
        bcmath \
        bz2 \
        calendar \
        dba \
        gettext \
        #ereg \ 
        #mhash \
        #mysql \
        iconv \
        mbstring \
        pcntl \
        shmop \
        exif \
        mysqli \
        pdo_mysql \
        opcache \
        soap \
        sockets \
        sysvmsg \
        sysvsem \
        sysvshm \
        wddx \
        zip \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && pecl install redis zmq-beta \
    && docker-php-ext-enable redis zmq \
    && apt-get install -y \
        curl \
        libxrender1 \
        libfontconfig \
        libxtst6 \
        xz-utils \
        zlib1g-dev \
        libzmq-dev \
    && curl "https://downloads.wkhtmltopdf.org/0.12/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz" -L -o "wkhtmltopdf.tar.xz" \
    && tar Jxvf wkhtmltopdf.tar.xz \
    && mv wkhtmltox/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf

ADD install_composer.sh /install_composer.sh
RUN /install_composer.sh && rm /install_composer.sh
    