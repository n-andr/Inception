#!/bin/bash
set -e

ENV_FILE="srcs/.env"

if [ -f "$ENV_FILE" ]; then
    echo ".env already exists — skipping."
    exit 0
fi

echo "Creating .env..."

MYSQL_PASSWORD=$(openssl rand -hex 8)
MYSQL_ROOT_PASSWORD=$(openssl rand -hex 8)

{
    echo "DOMAIN_NAME=${USER}.42.fr"
    echo "MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}"
    echo "MYSQL_DATABASE=wordpress"
    echo "MYSQL_USER=wpuser"
    echo "MYSQL_PASSWORD=${MYSQL_PASSWORD}"
    echo "WORDPRESS_DB_HOST=mariadb:3306"
    echo "WORDPRESS_DB_NAME=wordpress"
    echo "WORDPRESS_DB_USER=wpuser"
    echo "WORDPRESS_DB_PASSWORD=${MYSQL_PASSWORD}"
} > "$ENV_FILE"

echo ".env created successfully."
