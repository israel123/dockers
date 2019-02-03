#!/bin/bash
source .env
docker-compose down  && docker-compose ps
sudo rm -rf ./data/
