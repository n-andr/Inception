# FROM mariadb:latest
# EXPOSE 3306


# FROM    alpine:3.13

# RUN     apk update && apk upgrade && apk add --no-cache \
#         mariadb \
#         mariadb-client
        
# COPY    tools/configure.sh /tmp/configure.sh

# ENTRYPOINT ["sh", "/tmp/configure.sh"]


FROM debian:bookworm-slim

# Install MariaDB server and remove package lists to reduce size
RUN apt-get update && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/*

# Copy configuration and init script
COPY conf/my.cnf /etc/mysql/my.cnf
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Create database directory for volume
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

# default port 
EXPOSE 3306 

# Start MariaDB safely and run init script
ENTRYPOINT ["/usr/local/bin/setup.sh"]