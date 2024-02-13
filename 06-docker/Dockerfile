FROM eclipse-temurin:17

EXPOSE 8080

RUN mkdir -p /home/app
COPY ./build/libs/docker-exercises-project-1.0-SNAPSHOT.jar /home/app
WORKDIR /home/app

CMD ["java", "-jar", "docker-exercises-project-1.0-SNAPSHOT.jar"]

