#!/bin/env sh

echo "INFO: Cleaning non running instances ..."
docker ps --all | awk '!/CON/{print $1}' | xargs docker rm
echo "INFO: Clean non used images ..."
docker images | awk '!/REPO/{print $3}' | xargs docker rmi
echo "INFO: Clean unused networks ..."
docker network prune
echo "INFO: Docker is fresher now  :)"
