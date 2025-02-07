# Dockerfile para Ianseo
FROM php:8.0-apache

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    unzip \
    wget \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql

# Configurar Apache
RUN a2enmod rewrite
COPY ianseo.conf /etc/apache2/sites-available/000-default.conf

# Descargar Ianseo
WORKDIR /var/www/html
RUN wget -O ianseo.zip https://www.ianseo.net/Release/Ianseo_20241208.zip \
    && unzip ianseo.zip \
    && rm ianseo.zip

# Permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 8080
CMD ["apache2-foreground"]
