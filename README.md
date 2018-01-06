# ServiceConfig
Spring Framework based Service Configuration

Based on https://projects.spring.io/spring-cloud/ and https://github.com/spring-cloud-samples/configserver.

## Dependencies
At least: Java 8 and Maven 3.5

## Build Service Config
mvn package -DskipTests=true

## Run Service Registry
### Environment variables
#### EUREKA_ZONE 
Default value: http://127.0.0.1:8761/eureka/
Defining all available Eureka Instances.
#### CONFIG_LOCATION
Default value: file:////config (for Windows: SET CONFIG_LOCATION=file:///c:\config)
Defining the folder which all application.yml are stored.

### Windows
java -jar target\ServiceConfig-0.0.1-SNAPSHOT.jar

### Linux (service enabled)
./target/ServiceConfig-0.0.1-SNAPSHOT.jar start

## Docker build
docker build -t serviceconfig:latest . --build-arg JAR_FILE=./target/ServiceConfig-0.0.1-SNAPSHOT.jar

## Docker run
docker run --name serviceconfig -d -p 8888:8888 --link serviceregistry:serviceregistry -v ~/config:/config -v /tmp:/tmp -e EUREKA_ZONE=$EUREKA_ZONE serviceconfig:latest
