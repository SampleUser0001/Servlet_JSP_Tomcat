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

pushd pulldown > /dev/null
mvn clean compile package
popd
cp ./pulldown/target/pulldown.war ./docker/webapps/

pushd jsp_include_param > /dev/null
mvn clean compile package
popd
cp ./jsp_include_param/target/jsp_include_param.war ./docker/webapps/

pushd ./jsp_include_param/variants/jsp_include_param_rendered > /dev/null
mvn clean compile package
popd
cp ./jsp_include_param/variants/jsp_include_param_rendered/target/jsp_include_param_rendered.war ./docker/webapps/

pushd ./jsp_include_param/variants/jsp_include_param_rendered_02 > /dev/null
mvn clean compile package
popd
cp ./jsp_include_param/variants/jsp_include_param_rendered_02/target/jsp_include_param_rendered_02.war ./docker/webapps/

pushd ./input_model_common_jsp > /dev/null
mvn clean compile package
popd
cp ./input_model_common_jsp/target/input_model_common_jsp.war ./docker/webapps/

pushd docker > /dev/null
docker-compose up -d
pushd logs > /dev/null
sudo chmod +r *.*
popd
popd
