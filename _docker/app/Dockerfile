# Use the official PHP 8.1 FPM base image
FROM php:8.3-fpm

ENV http_proxy=http://task:hSPCoZ1RCUOKLnDjtrw6@proxy.almatv.kz:3128
ENV https_proxy=http://task:hSPCoZ1RCUOKLnDjtrw6@proxy.almatv.kz:3128

# Update package lists and install necessary packages
RUN apt-get update && apt-get install -y \
    apt-utils \
    libpq-dev \
    libpng-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    redis-tools && \
    docker-php-ext-install pdo_mysql bcmath gd pcntl zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Redis extension
RUN pecl install redis && docker-php-ext-enable redis

# Copy custom PHP configuration
COPY ./_docker/app/php.ini /usr/local/etc/php/conf.d/php.ini

# Set the working directory
WORKDIR /var/www/laravel

# Copy application files
COPY . /var/www/laravel

# # Install Node.js and npm
# RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
#     apt-get install -y nodejs && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies
RUN composer install --no-interaction --optimize-autoloader

# Copy and modify .env file
RUN cp .env.example .env

# Generate application key
RUN php artisan key:generate

# # Set npm cache directory to avoid permission issues
# RUN npm config set cache /var/www/.npm-cache --global

# # Install npm dependencies
# RUN npm install

# # Build assets if necessary
# RUN npm run build

# Expose port 9000 and start PHP-FPM server
EXPOSE 9000
CMD ["php-fpm"]
