.PHONY: all re fclean down clean

USER = sejinkim
DATA_PATH = /home/$(USER)/data

all:
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

re:
    @make clean
	@make all

clean:
	@docker stop $$(docker ps -qa);
	@docker rm $$(docker ps -qa);
	@docker rmi -f $$(docker images -qa);
	@docker volume rm $$(docker volume ls -q);

fclean:
	@make clean
	@sudo rm -rf $(DATA_PATH)/mysql/*
	@sudo rm -rf $(DATA_PATH)/wordpress/*