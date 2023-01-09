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

-include .env
DB_DOCKER=docker exec blog-postgres
DB_NAME=${DOCKER_POSTGRESQL_DB_NAME}
DB_CONTAINER=blog-postgres
DB_USER=postgres
PSQL=${DB_DOCKER} psql -U postgres $(if $(1),-d $(1)) $(if $(2),-c '$(2)')
docker-db-recreate:
	$(call PSQL) -c 'DROP DATABASE IF EXISTS ${DB_NAME}'
	$(call PSQL) -c 'CREATE DATABASE ${DB_NAME} OWNER ${DB_USER}'
.PHONY: docker-db-recreate

docker-db-schema:
	docker-compose run --rm php-cli bin/console doctrine:schema:create --no-interaction
.PHONY: docker-db-schema

#Установить разрешения для папок, которые создал Docker
docker-set-perms: 
	docker run -v $(shell pwd):/app -w /app --rm alpine:latest find ./bin -name '.?*' -prune -o -exec chmod 777 {} +
.PHONY: docker-set-perms

