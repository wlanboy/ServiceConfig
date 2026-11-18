FROM eclipse-temurin:25-jre-noble
VOLUME /config
VOLUME /tmp
WORKDIR /app
# Dateien gehören root und sind für den App-User nur lesbar
COPY target/serviceconfig-*.jar app.jar
COPY bootstrap.properties application.yml ./
EXPOSE 8888
# Nicht als root laufen: UID/GID 1000 (User "ubuntu" im Base-Image), numerisch für runAsNonRoot
USER 1000:1000
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]
