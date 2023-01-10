.PHONY: nginx-log php-log redis-log postgresql-log 

nginx-log: 
	$(info Nginx stdout logs)
	docker-compose logs -f nginx

php-fpm-log: 
	$(info Php-fpm stdout logs)
	docker-compose logs -f php-fpm

php-cli-log: 
	$(info Php-fpm stdout logs)
	docker-compose logs -f php-cli

redis-log: 
	$(info Redis stdout logs)
	docker-compose logs -f redis

postgresql-log: 
	$(info PostgreSQL stdout logs)
	docker-compose logs -f db