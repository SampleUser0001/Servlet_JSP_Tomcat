#!/bin/bash

compose_file=$1

pushd docker > /dev/null
docker-compose down
popd

pushd app
./gradlew war
popd

cp ./app/app/build/libs/app.war ./docker/webapps/

pushd use_el/tomcat-helloworld
mvn clean compile package
popd

cp ./use_el/tomcat-helloworld/target/tomcat-helloworld.war ./docker/webapps/

pushd pulldown
mvn clean compile package
popd
cp ./pulldown/target/pulldown.war ./docker/webapps/

pushd radio
mvn clean compile package
popd
cp ./radio/target/radio.war ./docker/webapps/


pushd jsp_include_param
mvn clean compile package
popd
cp ./jsp_include_param/target/jsp_include_param.war ./docker/webapps/

pushd post_valiable_length_array
mvn clean compile package
popd
cp ./post_valiable_length_array/target/post_valiable_length_array.war ./docker/webapps/


pushd ./jsp_include_param/variants/jsp_include_param_rendered
mvn clean compile package
popd
cp ./jsp_include_param/variants/jsp_include_param_rendered/target/jsp_include_param_rendered.war ./docker/webapps/

pushd ./jsp_include_param/variants/jsp_include_param_rendered_02
mvn clean compile package
popd
cp ./jsp_include_param/variants/jsp_include_param_rendered_02/target/jsp_include_param_rendered_02.war ./docker/webapps/

pushd ./input_model_common_jsp
mvn clean compile package
popd
cp ./input_model_common_jsp/target/input_model_common_jsp.war ./docker/webapps/

pushd ./rest_api
mvn clean compile package
popd
cp ./rest_api/target/rest_api.war ./docker/webapps/

pushd docker > /dev/null

if [ -z "$compose_file" ]; then
    docker_compose_yml="compose.yml"
else
    docker_compose_yml="compose.${compose_file}.yml"
fi
docker-compose -f $docker_compose_yml up -d


pushd logs > /dev/null
sudo chmod +r *.*
popd
popd
