FROM openjdk:18-jdk-alpine AS anaconda
ADD ana-petclinic.tar .
WORKDIR ana-petclinic
RUN ./mvnw package -DskipTests=true

FROM openjdk:18-jdk-alpine
COPY --from=anaconda /ana-petclinic/target/spring-petclinic-2.7.0-SNAPSHOT.jar /
CMD ["java", "-jar", "-Dspring.profiles.active=mysql", "/spring-petclinic-2.7.0-SNAPSHOT.jar"]
