FROM openjdk:18-jdk-alpine

ADD target/spring-petclinic-2.7.3.jar spring-petclinic-2.7.3.jar

CMD ["java", "-jar", "spring-petclinic-2.7.3.jar"]
