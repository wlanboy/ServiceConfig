#!/bin/bash
set -e

mvn package -DskipTests=true
docker build -t serviceconfig:latest . --build-arg JAR_FILE=./target/ServiceConfig-0.0.1-SNAPSHOT.jar
docker run --name serviceconfig -d -p 8888:8888 --link serviceregistry:serviceregistry -v ~/config:/config -v /tmp:/tmp serviceconfig:latest
