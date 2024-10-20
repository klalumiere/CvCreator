FROM eclipse-temurin:23-noble AS base

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --no-install-recommends \
        tini \
    && rm -rf /var/lib/apt/lists/*


FROM node:20-bookworm AS frontend

COPY frontend /builder/frontend
WORKDIR /builder/frontend
RUN npm install \
    && npm run build


FROM clojure:temurin-23-lein-2.11.2-noble AS backend

WORKDIR /builder
COPY project.clj project.clj
COPY --from=frontend /builder/frontend/build resources/public
COPY src src
RUN lein ring uberjar


FROM base

WORKDIR /app
COPY --from=backend /builder/target/uberjar/cv-creator.jar /app/cv-creator.jar
COPY data /app/data
ENTRYPOINT ["/bin/tini", "--"]
CMD ["java", "-Xmx192m", "-jar", "/app/cv-creator.jar"]
