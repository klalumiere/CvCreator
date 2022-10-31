FROM clojure:temurin-19-lein-2.9.10-alpine as base

RUN apk add --no-cache tini


FROM clojure:temurin-19-lein-2.9.10-alpine AS builder

WORKDIR /builder
COPY project.clj project.clj
COPY src src
RUN lein uberjar


FROM base

COPY --from=builder /builder/target/default+uberjar/cv-creator.jar /app/cv-creator.jar
ENTRYPOINT ["/sbin/tini", "--", "java", "-jar", "/app/cv-creator.jar"]
