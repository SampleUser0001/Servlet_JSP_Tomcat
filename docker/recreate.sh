#!/bin/bash

compose_file=$1

docker-compose -f $compose_file down
docker-compose -f $compose_file build --no-cache
docker-compose -f $compose_file up -d
