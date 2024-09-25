#!/bin/sh
# Change permissions for Laravel storage and bootstrap/cache directories
chmod -R 777 /var/www/laravel/storage /var/www/laravel/bootstrap/cache
exec "$@"