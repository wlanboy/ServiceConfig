# ServiceConfig
Spring Framework based Service Configuration

Based on https://projects.spring.io/spring-cloud/ and https://github.com/spring-cloud-samples/configserver.

## Dependencies
At least: Java 8 and Maven 3.5

## Build Service Config
mvn package -DskipTests=true

## Run Service Config
### Environment variables
#### EUREKA_ZONE 
Default value: http://127.0.0.1:8761/eureka/
Defining all available Eureka Instances.
#### CONFIG_LOCATION
Default value: file:////config (for Windows: SET CONFIG_LOCATION=file:///c:\config)
Defining the folder which all application.yml are stored.

### Windows
java -jar target\serviceconfig-0.1.1-SNAPSHOT.jar

### Linux (service enabled)
./target/serviceconfig-0.1.1-SNAPSHOT.jar start

## Docker build
docker build -t serviceconfig:latest . --build-arg JAR_FILE=./target/serviceconfig-0.1.1-SNAPSHOT.jar

## Docker run
export DOCKERHOST=192.168.0.100
docker run --name serviceconfig -m 256M -d -p 8888:8888 -v /tmp:/tmp -v ~/config:/config -e DOCKERHOST=$DOCKERHOST -e EUREKA_ZONE=http://$DOCKERHOST:8761/eureka/ serviceconfig:latest
