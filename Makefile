NAME = inception
COMPOSE_FILE = srcs/docker-compose.yml
ENV_SRC = ../conf_vars/.env
ENV_FILE = srcs/.env



all: up

up:
	@echo "Setting up environment..."
	@if [ -f $(ENV_DST) ]; then \
		echo "srcs/.env already exists — skipping copy."; \
		else \
		cp $(ENV_SRC) $(ENV_FILE); \
		echo ".env copied to srcs/"; \
	fi
	@echo "Starting containers..."
	docker compose -f $(COMPOSE_FILE) up -d --build


down:
	@echo "Stopping containers..."
	docker compose -f $(COMPOSE_FILE) down


restart: down up


clean:
	@echo "Cleaning containers, networks, and images (keeping data)..."
	docker compose -f $(COMPOSE_FILE) down --rmi all

fclean: clean
	@echo "Removing generated files..."
	rm -rf $(CERT_DIR)
	@echo "Full cleanup (including volumes and data)..."
	docker compose -f $(COMPOSE_FILE) down --volumes --rmi all

re: fclean all

logs:
	@echo "Showing live container logs (Ctrl+C to exit)..."
	docker compose -f $(COMPOSE_FILE) logs -f

status:
	@echo "Showing running containers..."
	docker ps -a

.PHONY: all up down restart clean fclean re logs status