FROM nextcloud:fpm-alpine
COPY ./previewgenerator /var/www/html/apps/previewgenerator
RUN echo "0 3 * * * php -f /www/wwwroot/nextcloud/occ preview:pre-generate -vvv" >> /etc/crontabs/www-data
