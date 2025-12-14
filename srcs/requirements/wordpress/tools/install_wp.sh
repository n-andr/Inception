#!/bin/sh
echo "Checking database connection..."
while ! mariadb -h$WORDPRESS_DB_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME --skip-ssl; do # &>/dev/null; do
	echo "Database is not ready yet, waiting 3 more seconds"
    sleep 3
done
echo "Database is ready"

# if [ ! -f "/var/www/html/index.php" ]; then
#     wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci"
#     wp core install --url=$DOMAIN_NAME --title="My inseption" --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL
#     wp user create $WP_ADMIN_USR $WP_ADMIN_EMAIL --role=author --user_pass=$WP_ADMIN_PWD
#     wp theme install twentytwentythree --activate
# fi

if ! wp core is-installed --allow-root; then
    wp config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" \
        --dbcharset="utf8" \
        --dbcollate="utf8_general_ci" \
        --allow-root

    wp core install \
        --url="$DOMAIN_NAME" \
        --title="My inception" \
        --admin_user="$WP_ADMIN_USR" \
        --admin_password="$WP_ADMIN_PWD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    # wp theme install inspiro --activate --allow-root 
	# use default theme
	wp option update default_comment_status closed --allow-root
	wp option update comment_moderation 0 --allow-root
	wp option update comments_notify 0 --allow-root
	wp option update moderation_notify 0 --allow-root
	wp user create "$WP_USER" "$WP_USER_EMAIL" --role=editor --user_pass="$WP_USER_PWD" --allow-root

fi

exec "$@"