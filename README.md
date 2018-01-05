# ServiceConfig
Spring Framework based Service Configuration

Based on https://projects.spring.io/spring-cloud/ and https://github.com/spring-cloud-samples/configserver.

## Dependencies
At least: Java 8 and Maven 3.5

## Build Service Registry
mvn package -DskipTests=true

## Run Service Registry
### Environment variables
#### EUREKA_ZONE 
Default value: http://127.0.0.1:8761/eureka/
Defining all available Eureka Instances.
#### CONFIG_LOCATION
Default value: file:///${user.home}/config
Defining the folder which all application.yml are stored.

### Windows
java -jar target\ServiceConfig-0.0.1-SNAPSHOT.jar

### Linux (service enabled)
./target/ServiceConfig-0.0.1-SNAPSHOT.jar start
