all : up

up : 
	@sh ./srcs/requirements/wordpress/tools/create_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml up -d

down : 
	@docker-compose -f ./srcs/docker-compose.yml down --rmi all

stop : 
	@docker-compose -f ./srcs/docker-compose.yml stop

start : 
	@docker-compose -f ./srcs/docker-compose.yml start

status : 
	@docker ps