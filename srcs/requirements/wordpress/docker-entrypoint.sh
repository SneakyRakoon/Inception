#!/bin/bash
set -e

# Attendre que MariaDB soit prêt
until mysql -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} >/dev/null 2>&1; do
  sleep 1
done

# Télécharger WordPress si pas présent
if [ ! -f wp-config.php ]; then
    wp core download --allow-root
    wp config create --allow-root \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=${MYSQL_HOST}
    
    wp core install --allow-root \
        --url=${DOMAIN_NAME} \
        --title="My WordPress Site" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL}
    
    wp user create --allow-root \
        ${WP_USER} ${WP_EMAIL} \
        --user_pass=${WP_PASSWORD}
fi

exec "$@"