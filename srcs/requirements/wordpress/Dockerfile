# FROM wordpress:php8.2-fpm    
# # WordPress running PHP-FPM for use with Nginx
# EXPOSE 9000                  
# # FPM listens on this port for Nginx to connect
FROM alpine:3.22

RUN apk update
RUN	apk add --no-cache --quiet --update curl bash vim

RUN	apk add --no-cache --quiet --update mariadb-client

RUN	apk add --no-cache --quiet --update php php-phar php-json php-curl php-fpm php-mysqli php-iconv

RUN	adduser -S wordpress &&	addgroup -S wordpress

RUN	 wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN	 chmod +x wp-cli.phar

RUN	cp wp-cli.phar /usr/bin/wp

WORKDIR	/var/www/html

RUN php -d memory_limit=512M "$(which wp)" core download 

COPY tools/install_wp.sh /usr/local/bin/install_wp.sh

COPY conf/www.conf /etc/php-fpm/www.conf

EXPOSE 9000 

ENTRYPOINT ["/usr/local/bin/install_wp.sh"]

CMD [ "php-fpm83", "--fpm-config", "/etc/php-fpm/www.conf", "--nodaemonize"]


