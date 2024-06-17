.PHONY: all re down clean

all:
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

re:
	@docker compose -f srcs/docker-compose.yml up -d --build

clean:
	@docker stop $$(docker ps -qa);
	docker rm $$(docker ps -qa);
	docker rmi -f $$(docker images -qa);
	docker volume rm $$(docker volume ls -q);

fclean: clean
	rm -rf /home/junmoon/data/mysql/*
	rm -rf /home/junmoon/data/wordpress/*