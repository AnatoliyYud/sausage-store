#!/bin/bash

docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker network create -d bridge sausage_network || true

if [ $(docker ps | grep backend-blue | wc -l) = 1 ]
 then
docker rm -f backend-green || true
docker pull ${CI_REGISTRY_IMAGE}/sausage-backend:latest
docker-compose up -d --build backend-green
sleep 25
    if [ $(docker ps | grep backend-blue | grep healthy | wc -l) = 1 ]
    then
    docker rm -f backend-blue
    else
    docker rm -f backend-green
    fi
elif [ $(docker ps | grep backend-green | wc -l) = 1 ]
then
docker rm -f backend-blue || true
docker pull ${CI_REGISTRY_IMAGE}/sausage-backend:latest
docker-compose up -d --build backend-blue
sleep 25
    if [ $(docker ps | grep backend-green | grep healthy | wc -l) = 1 ]
    then
    docker rm -f backend-green
    else
    docker rm -f backend-blue
    fi
fi

