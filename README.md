##READ ME 

### pre-requirement

you need to download any library (like drupal) as submodule to ```src``` the clone it will 
look like this ```git add submodule <repo> src```

docker compose is contain many dockers you need  to comment any docker to don't 
need the environment specific

Docker commands:

### ./run.sh install

run this command only for the first time. It creates the files and pulls the Docker images.

### ./run.sh build

run this command to change the docker's files. It re-builds them.

### ./run.sh start

run this command if the docker stopped.

### ./run.sh stop

run this command to stop the docker.

### ./run.sh unbuild 

run this command to stop the docker and shut it down.

### ./run.sh uninstall

run this command to stop the docker and to remove all the files which were created during the installation.

## config .env file 

copy .env.example file to .env file and add the missing variables. 

PASSWORD= use to password the DB

WEB_PORT_EXTERNAL= the port number of the local site (like: localhost:3000)

PHPMYADMIN_PORT_EXTERNAL= the port number of the phpMyAdmin (like: localhost:9000).