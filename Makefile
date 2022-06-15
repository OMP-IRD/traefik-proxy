all: run

run:
	docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

logs:
	docker-compose -f docker-compose.yml -f docker-compose.prod.yml logs -f

run-dev:
	docker-compose -f docker-compose.yml up -d
