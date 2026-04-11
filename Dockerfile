FROM eclipse-temurin:25-jre-noble
VOLUME /config
VOLUME /tmp
COPY target/serviceconfig-*.jar app.jar
ADD bootstrap.properties bootstrap.properties
ADD application.yml application.yml
EXPOSE 8888
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
