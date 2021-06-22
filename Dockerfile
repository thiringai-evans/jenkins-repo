From openjdk:8-jre-alpine
EXPOSE 5050
COPY ./src /usr/app/
WORKDIR /usr/app
ENTRYPOINT ["java", "-jar", "java-maven-app-1.0-SNAPSHOT.jar"]
