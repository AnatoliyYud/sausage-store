#!/bin/bash

docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker network create -d bridge sausage_network || true
docker pull ${CI_REGISTRY_IMAGE}/sausage-backend-report:latest
docker stop sausage-store-backend-report || true
docker rm sausage-store-backend-report || true
docker compose up -d --build backend-report
