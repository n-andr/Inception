# FROM debian:latest
#
# RUN apt-get update && apt-get install -y nginx

# CMD ["nginx", "-g", "daemon off;"]

FROM alpine:3.19

# System deps: nginx, openssl (for cert generation), and bash/sh for scripts
RUN apk add --no-cache nginx openssl bash

# Create runtime dirs
RUN mkdir -p /var/www/html /var/run/nginx /etc/nginx/conf.d /etc/nginx/certs


# Copy config and tools
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/site.conf  /etc/nginx/conf.d/site.conf
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]

# choose an Nginx base image,
# copy an HTML file into the right directory,
# and expose a port.

# FROM nginx:latest

# nginx:latest — uses a lightweight Debian-based Linux with Nginx preinstalled.
# nginx:alpine — even smaller, based on Alpine Linux.

# Copies files from your local folder into the container filesystem.
# what to copy - > destination
# COPY index.html /usr/share/nginx/html

# Documents which port the service inside listens on (not a port mapping).
EXPOSE 443