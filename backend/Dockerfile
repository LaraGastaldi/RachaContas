FROM php:8.3-apache

RUN apt-get update && apt-get install -y unzip curl libcurl4-openssl-dev libonig-dev \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

RUN docker-php-ext-install pdo_mysql curl mbstring

ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN a2enmod rewrite

COPY . /var/www/html

WORKDIR /var/www/html

ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer install

CMD ["apache2-foreground"]