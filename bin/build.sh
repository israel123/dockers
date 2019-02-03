#!/bin/bash

# sub moduels
git submodule init
git submodule update

source .env

docker-compose up -d --build && docker-compose ps

#docker exec ${PROJECT_NAME}-php bash -c 'composer install -o'


./bin/fix-permissions.sh