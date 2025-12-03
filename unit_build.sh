#!/bin/bash

unit=$1

pushd $unit
mvn clean compile package
popd

cp $unit/target/$unit.war docker/webapps/

pushd docker/logs > /dev/null
sudo chmod +r *.*
popd
