##READ ME 

### pre-requirement

you need to download any library (like drupal) as submodule to ```src``` the clone it will 
look like this ```git clone <repo> src```

docker compose is contain many dockers you need  to comment any docker to don't 
need the environment specific

have a 6 options to deployment docker.

### ./run.sh install

run first time, it's to  create the files and pull Docaker images.

### ./run.sh build

run if change the docker's file. this is build them.

### ./run.sh start

run if docker is stopped.

### ./run.sh stop

run to stop doocker.

### ./run.sh unbuild 

run to stop docker and down them.

### ./run.sh uninstall

run to stop docker and remove files to create at installed docker.

## config .env file 

copy .env.example file to .env file and fill the variable 

PASSWORD= use to password the DB

WEB_PORT_EXTERNAL= the port is to get site from computer (like: localhost:3000)

PHPMYADMIN_PORT_EXTERNAL= the port is to get phpMyAdmin from computer (like: localhost:9000).