up:
	docker-compose up -d --build --force-recreate
.PHONY: up

down:
	docker-compose down
.PHONY: down

docker-build-backend:
	docker-compose run --rm php-cli composer install --no-interaction -o
.PHONY: docker-build-backend

docker-cc:
	docker-compose run --rm php-cli bin/console cache:clear --no-warmup --no-debug
.PHONY: docker-build-backend

php-fpm-cli:
	docker-compose exec php-fpm sh
.PHONY: docker-build-backend

#Установить разрешения для папок, которые создал Docker
docker-set-perms: 
	docker run -v $(shell pwd):/app -w /app --rm alpine:latest find ./config -name '.?*' -prune -o -exec chmod 777 {} +
.PHONY: docker-set-perms

