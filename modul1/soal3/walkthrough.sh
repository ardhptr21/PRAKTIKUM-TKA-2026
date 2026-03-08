#!/bin/bash

# build
docker build -t eva-web-a07:v1 .

# run
docker run -d --name eva-container-a07 -p 8080:80 -v $PWD/app:/usr/share/nginx/html/ eva-web-a07:v1

# exec
docker exec -it eva-container-a07 bash