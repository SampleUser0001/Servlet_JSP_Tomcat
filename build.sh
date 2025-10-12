#!/bin/bash
pushd docker > /dev/null
docker-compose down
popd

./gradlew war

cp ./app/build/libs/app.war ./docker/webapps/

pushd docker > /dev/null
docker-compose up -d
popd
