#!/bin/bash
set -e

echo "Starting MariaDB initialization..."


# Properly initialize MariaDB
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Start MariaDB temporarily
mysqld_safe --user=mysql &

# Wait for MariaDB to be ready (local connection only)
until mysql -h localhost -u root -e "SELECT 1;" >/dev/null 2>&1; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Initial configuration - ADD NETWORK PERMISSIONS FOR ROOT
mysql -h localhost -u root << EOF
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Stop temporary MariaDB (now with the correct password)
mysqladmin -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

echo "MariaDB initialization complete."
echo "Starting MariaDB server..."
exec mysqld --user=mysql --bind-address=0.0.0.0