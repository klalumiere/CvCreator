FROM clojure:temurin-23-lein-2.11.2-noble AS base

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --no-install-recommends \
        tini \
    && rm -rf /var/lib/apt/lists/*


FROM clojure:temurin-23-lein-2.11.2-noble AS builder

WORKDIR /builder
COPY project.clj project.clj
COPY src src
RUN lein ring uberjar


FROM base

COPY --from=builder /builder/target/default+uberjar/cv-creator.jar /app/cv-creator.jar
ENTRYPOINT ["/sbin/tini", "--", "java", "-jar", "/app/cv-creator.jar"]
