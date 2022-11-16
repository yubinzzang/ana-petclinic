FROM openjdk:18-jdk-alpine

EXPOSE 8080

ADD target/spring-petclinic-2.7.0-SNAPSHOT.jar petclinic.jar

ENTRYPOINT ["java" ,"-jar","-Dspring.profiles.active=mysql", "petclinic.jar"]
