#!/bin/bash
set -e

echo "Starting WordPress setup..."
echo "Waiting for database connection..."

until nc -z ${MYSQL_HOST} 3306; do
    echo "port 3306 not ready, waiting..."
    sleep 2
done

until timeout 10 mysql -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} >/dev/null 2>&1; do
  echo "Database not ready, waiting..."
  sleep 1
done

echo "Database connection successful!"

# Download WordPress if not present
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

# Modify PHP-FPM configuration to listen on all interfaces
sed -i 's/listen = .*/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf

exec "$@"