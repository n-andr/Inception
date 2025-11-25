NAME = inception
COMPOSE_FILE = srcs/docker-compose.yml
ENV_FILE = srcs/.env
CERT_DIR = srcs/requirements/nginx/tools/certs
CERT_KEY = $(CERT_DIR)/server.key
CERT_CRT = $(CERT_DIR)/server.crt
SECRETS_DIR = secrets


all: setup up

setup:
	@echo "Setting up..."
	@if [ ! -f $(ENV_FILE) ]; then \
	echo "Creating .env..."; \
	echo "DOMAIN_NAME=$(USER).42.fr" > $(ENV_FILE); \
	echo "MYSQL_ROOT_PASSWORD=$$(openssl rand -hex 8)" >> $(ENV_FILE); \
	echo "MYSQL_DATABASE=wordpress" >> $(ENV_FILE); \
	echo "MYSQL_USER=wpuser" >> $(ENV_FILE); \
	echo "MYSQL_PASSWORD=$$(openssl rand -hex 8)" >> $(ENV_FILE); \
	echo "WORDPRESS_DB_HOST=mariadb:3306" >> $(ENV_FILE); \
	echo "WORDPRESS_DB_NAME=wordpress" >> $(ENV_FILE); \
	echo "WORDPRESS_DB_USER=wpuser" >> $(ENV_FILE); \
	echo "WORDPRESS_DB_PASSWORD=$$(grep MYSQL_PASSWORD $(ENV_FILE) | cut -d= -f2)"; \
	fi; \
	@if [ ! -f $(CERT_KEY) ]; then \
		echo "🔐 Generating self-signed SSL certificate..."; \
		mkdir -p $(CERT_DIR); \
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout $(CERT_KEY) -out $(CERT_CRT) \
		-subj "/C=DE/ST=Berlin/L=Berlin/O=42School/CN=$(USER).42.fr"; \
	fi; \
	@echo "Setup complete."


up:
	@echo "Starting containers..."
	docker compose -f $(COMPOSE_FILE) up -d --build


down:
	@echo "Stopping containers..."
	docker compose -f $(COMPOSE_FILE) down


restart: down up


clean:
	@echo "Cleaning containers, networks, and images (keeping data)..."
	docker compose -f $(COMPOSE_FILE) down --rmi all

deepclean:
	@echo "Full cleanup (including volumes and data)..."
	docker compose -f $(COMPOSE_FILE) down --volumes --rmi all

fclean: clean
	@echo "Removing generated files..."
	rm -rf $(CERT_DIR) $(ENV_FILE)

re: fclean all

logs:
	@echo "Showing live container logs (Ctrl+C to exit)..."
	docker compose -f $(COMPOSE_FILE) logs -f

status:
	@echo "Showing running containers..."
	docker ps -a

.PHONY: all setup up down restart clean deepclean fclean re logs status