#!/bin/bash

./gradlew war

cp ./app/build/libs/app.war ./docker/webapps/
