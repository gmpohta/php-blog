.PHONY: nginx-cli php-cli

nginx-cli:
	$(info Enter nginx service console)
	docker-compose execnginx sh

php-fpm-cli: 
	$(info Enter php service console)
	docker-compose exec php-fpm sh
