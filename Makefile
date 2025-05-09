DOCKER_REGISTRY=jparkkennaby
IMAGE_NAME=graphql-faker-server
DOCKER_IMAGE=$(DOCKER_REGISTRY)/$(IMAGE_NAME)

dev:
	npm start

docker-build:
	docker build -t ${DOCKER_IMAGE} .

docker-run:
	docker run -it \
	-p 3000:3000 \
	-e SCHEMA_FILE_NAME=schema_extension \
	-e ALLOWED_HOSTS=http://localhost:5173 \
	-e SERVER_PORT=3000 \
	-e EXTEND_URL=https://swapi-graphql.netlify.app/graphql \
	${DOCKER_IMAGE}

docker-debug:
	docker run -it \
	-p 3000:3000 \
	-e SCHEMA_FILE_NAME=schema_extension \
	-e ALLOWED_HOSTS=http://localhost:5173 \
	-e SERVER_PORT=3000 \
	-e EXTEND_URL=https://swapi-graphql.netlify.app/graphql \
	${DOCKER_IMAGE} /bin/bash

docker-tag:
	docker tag ${DOCKER_IMAGE} ${DOCKER_IMAGE}:latest

docker-push:
	docker push ${DOCKER_IMAGE}:latest


# custom
docker-run-with-custom-headers:
	docker run -it \
	-p 3000:3000 \
	-e SCHEMA_FILE_NAME=schema_extension \
	-e ALLOWED_HOSTS=http://localhost:5173 \
	-e SERVER_PORT=3000 \
	-e EXTEND_URL=https://swapi-graphql.netlify.app/graphql \
	-e CUSTOM_HEADERS=TRUE \
	-v $(PWD)/.headers:/app/.headers \
	${DOCKER_IMAGE}