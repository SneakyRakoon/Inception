#!/bin/bash
set -e

# Initialiser MariaDB
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Démarrer MariaDB en arrière-plan
mysqld_safe --user=mysql &

# Attendre que MariaDB soit prêt
until mysqladmin ping >/dev/null 2>&1; do
  sleep 1
done

# Configuration initiale
mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Arrêter MariaDB temporaire et redémarrer proprement
mysqladmin shutdown
exec mysqld --user=mysql