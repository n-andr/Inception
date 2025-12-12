#!/bin/bash
set -e

# Create runtime dirs
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Initialize data directory if needed
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Run bootstrap SQL only once
if [ ! -f "/var/lib/mysql/.setup_done" ]; then
    echo "Bootstrapping MariaDB (creating users and database)..."
    cat > /tmp/init.sql <<-EOSQL
        FLUSH PRIVILEGES;
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL

    # Bootstrap mode bypasses auth completely
    mysqld --user=mysql --bootstrap < /tmp/init.sql

    rm -f /tmp/init.sql
    touch /var/lib/mysql/.setup_done
    echo "MariaDB bootstrap complete."
fi

echo "Starting MariaDB normally..."
exec mysqld_safe
