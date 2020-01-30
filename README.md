# ServiceConfig
Spring Framework based Service Configuration

Based on https://projects.spring.io/spring-cloud/ and https://github.com/spring-cloud-samples/configserver.

## Dependencies
At least: Java 8 and Maven 3.5

## Build Service Config
mvn package -DskipTests=true

## Run Service Config
### Environment variables
export KEYSTORE_PASSWORD=xxx
export KEYSTORE_SECRET=xxx

### KeyStores
keytool -genkey -alias serviceconfig -keystore /serviceconfig/serviceconfig.jks

#### CONFIG_LOCATION
Default value: https://github.com/wlanboy/cloudconfig

Defining the git repro which all yml files are stored.

### Windows
java -jar target\serviceconfig-0.1.1-SNAPSHOT.jar

### Linux (service enabled)
./target/serviceconfig-0.1.1-SNAPSHOT.jar start

## Docker build
docker build -t serviceconfig:latest . --build-arg JAR_FILE=./target/serviceconfig-0.1.1-SNAPSHOT.jar

## Docker run
docker run --name serviceconfig -m 256M -d -p 8888:8888 -e KEYSTORE_PASSWORD=$KEYSTORE_PASSWORD -e KEYSTORE_SECRET=$KEYSTORE_SECRET -v /tmp:/tmp -v /serviceconfig:/serviceconfig --restart unless-stopped wlanboy/serviceconfig:latest
