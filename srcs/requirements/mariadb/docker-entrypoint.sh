#!/bin/bash
set -e

echo "Starting MariaDB initialization..."

# Force la suppression de toutes les données existantes
rm -rf /var/lib/mysql/*

# Initialise MariaDB proprement
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Démarre MariaDB temporairement
mysqld_safe --user=mysql &

# Attendre que MariaDB soit prêt (connexion locale uniquement)
until mysql -h localhost -u root -e "SELECT 1;" >/dev/null 2>&1; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Configuration initiale - AJOUTER LES PERMISSIONS RÉSEAU POUR ROOT
mysql -h localhost -u root << EOF
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Arrêter MariaDB temporaire (maintenant avec le bon mot de passe)
mysqladmin -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

echo "MariaDB initialization complete."
echo "Starting MariaDB server..."
exec mysqld --user=mysql --bind-address=0.0.0.0