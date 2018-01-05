FROM openjdk:8-jdk-alpine
VOLUME /config
VOLUME /tmp
ARG JAR_FILE
ADD ${JAR_FILE} app.jar
ADD z83/bootstrap.properties bootstrap.properties
EXPOSE 8888
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

#docker build -t serviceconfig:latest . --build-arg JAR_FILE=./target/ServiceConfig-0.0.1-SNAPSHOT.jar
#docker run --name serviceconfig -d -p 8888:8888 --link serviceregistry:serviceregistry -v ~/config:/config -v /tmp:/tmp serviceconfig:latest
