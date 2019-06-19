FROM maven:3.6.1-jdk-12 AS builder
WORKDIR /build
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ /build/src/
RUN mvn package

FROM openjdk:12 as Target
COPY --from=builder /build/target/tracing-1.0.0.jar tracing.jar 

ENV EUREKA_URL=pad-b-registry

CMD wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \ 
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \ 
    && dockerize -wait tcp://$EUREKA_URL:8761 -timeout 60m yarn start

ENTRYPOINT ["java","-jar","tracing.jar"]

EXPOSE 8090