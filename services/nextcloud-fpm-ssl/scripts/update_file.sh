docker exec nextcloud_fpm_1 chown -Rc www-data:www-data ./data/$1/files
docker exec --user www-data nextcloud_fpm_1 php occ files:scan --path="$1/files"
