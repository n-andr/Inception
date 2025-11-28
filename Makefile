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
	@bash srcs/tools/create_env.sh
	@bash srcs/tools/create_certs.sh
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