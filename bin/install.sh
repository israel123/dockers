#!/bin/bash
source .env
./bin/build.sh
docker exec ${PROJECT_NAME}-php bash -c 'composer install -o'
sleep 10
docker exec ${PROJECT_NAME}-php bash -c 'drush site-install --db-url=mysql://root:${password}@db/hotelbeds -y'

