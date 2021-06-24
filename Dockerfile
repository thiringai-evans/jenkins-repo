From openjdk:8-jre-alpine
EXPOSE 5050
COPY ./src /usr/app/
WORKDIR /usr/app
cmd java -jar java-maven-app-*.jar
