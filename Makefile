.PHONY: all re fclean down clean

DOCKER_COMPOSE_PATH = ./srcs/docker-compose.yml

VOLUMES_PATH = $(HOME)/data
MARIA_DB_VOLUME_PATH = $(VOLUMES_PATH)/mysql
WORDPRESS_VOLUME_PATH = $(VOLUMES_PATH)/wordpress

all:
	@mkdir -p $(MARIA_DB_VOLUME_PATH) $(WORDPRESS_VOLUME_PATH)
	@sudo chown -R 999:999 $(MARIA_DB_VOLUME_PATH)
	@sudo docker compose -f $(DOCKER_COMPOSE_PATH) up -d --build

down:
	@sudo docker compose -f $(DOCKER_COMPOSE_PATH) down

re: clean all

clean: down
	@sudo docker ps -aq | xargs -r sudo docker rm -f
	@sudo docker image ls -q | xargs -r sudo docker rmi -f
	@sudo docker volume ls -q | xargs -r sudo docker volume rm

fclean: clean
	-@sudo docker system prune --all --force
	-@sudo rm -rf $(MARIA_DB_VOLUME_PATH)
	-@sudo rm -rf $(WORDPRESS_VOLUME_PATH)
