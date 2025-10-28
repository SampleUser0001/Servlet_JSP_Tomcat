#!/bin/bash
pushd docker > /dev/null
docker-compose down
popd

pushd app > /dev/null
./gradlew war
popd

cp ./app/app/build/libs/app.war ./docker/webapps/

pushd use_el/tomcat-helloworld
mvn clean compile package
popd

cp ./use_el/tomcat-helloworld/target/tomcat-helloworld.war ./docker/webapps/

pushd docker > /dev/null
docker-compose up -d
pushd logs > /dev/null
sudo chmod +r *.*
popd
popd
