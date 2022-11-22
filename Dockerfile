FROM openjdk:18-jdk-alpine AS anaconda
ADD spring-petclinic.tar .
WORKDIR spring-petclinic
RUN ./mvnw package -DskipTests=true

FROM openjdk:18-jdk-alpine
COPY --from=anaconda /spring-petclinic/target/spring-petclinic-2.7.0-SNAPSHOT.jar /
CMD ["java", "-jar", "-Dspring.profiles.active=mysql", "/spring-petclinic-2.7.0-SNAPSHOT.jar"]
