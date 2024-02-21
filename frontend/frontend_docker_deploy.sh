#!/bin/bash

docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker network create -d bridge sausage_network || true
docker pull ${CI_REGISTRY_IMAGE}/sausage-frontend:latest
docker stop sausage-store-frontend || true
docker rm sausage-store-frontend || true
docker compose up -d --build frontend

