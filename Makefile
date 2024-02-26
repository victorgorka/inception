COMPOSE = ./srcs/docker-compose.yml

all: up

up:
	mkdir -p /home/$(USER)/data/wordpress
	mkdir -p /home/$(USER)/data/mariadb
	sudo docker-compose -f $(COMPOSE) up -d --build

clean:
	sudo docker-compose -f $(COMPOSE) down
	docker rmi -f `docker images -qa`
	docker volume rm `docker volume ls -q`

fclean: clean
	rm -rf /home/$(USER)/data/mariadb
	rm -rf /home/$(USER)/data/wordpress

.PHONY: all up clean fclean
