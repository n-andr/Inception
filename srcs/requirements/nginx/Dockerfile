# FROM debian:latest
#
# RUN apt-get update && apt-get install -y nginx

# CMD ["nginx", "-g", "daemon off;"]




# choose an Nginx base image,
# copy an HTML file into the right directory,
# and expose a port.

FROM nginx:latest

# nginx:latest — uses a lightweight Debian-based Linux with Nginx preinstalled.
# nginx:alpine — even smaller, based on Alpine Linux.

# Copies files from your local folder into the container filesystem.
# what to copy - > destination
COPY index.html /usr/share/nginx/html

# Documents which port the service inside listens on (not a port mapping).
EXPOSE 80