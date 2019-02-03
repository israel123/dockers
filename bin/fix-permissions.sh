#!/bin/bash

source .env

SITE_USER=$USER
SITE_GROUP=33

sudo chown $SITE_USER:$SITE_GROUP -R src/
sudo chmod g=u -R src/
