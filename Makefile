DOCKER_COMPOSE_FILE	= srcs/docker-compose.yml
DATA_DIR			= /home/tsofien-/data
DATA_DIR_MARIADB	= $(DATA_DIR)/mariadb
DATA_DIR_WORDPRESS	= $(DATA_DIR)/wordpress

all:
	mkdir -p $(DATA_DIR_MARIADB) $(DATA_DIR_WORDPRESS)
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build

clean:
	docker compose -f $(DOCKER_COMPOSE_FILE) down -v --remove-orphans
	docker system prune -f

fclean:
	docker compose -f $(DOCKER_COMPOSE_FILE) down -v --rmi all --remove-orphans
	docker system prune -af
	sudo rm -rf $(DATA_DIR)

re: fclean all

down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down
	docker volume rm srcs_db_data || true    # ← APRÈS avoir arrêté les conteneurs
	docker system prune -f
stop:
	docker compose -f $(DOCKER_COMPOSE_FILE) stop

rebuild-nginx:
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build nginx

rebuild-mariadb:
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build mariadb

rebuild-wordpress:
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build wordpress

.PHONY: all clean fclean re re rebuild-nginx rebuild-mariadb rebuild-wordpress