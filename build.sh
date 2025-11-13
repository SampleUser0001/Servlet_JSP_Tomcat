#!/bin/bash
pushd docker
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

pushd docker
docker-compose up -d
pushd logs
sudo chmod +r *.*
popd
popd
