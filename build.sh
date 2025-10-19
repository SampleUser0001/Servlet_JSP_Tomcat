#!/bin/bash
pushd docker > /dev/null
docker-compose down
popd

pushd app > /dev/null
./gradlew war
popd

cp ./app/app/build/libs/app.war ./docker/webapps/

pushd docker > /dev/null
docker-compose up -d
pushd logs > /dev/null
sudo chmod +r *.*
popd
popd
