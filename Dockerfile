FROM node:20-bookworm AS frontend

COPY frontend /builder/frontend
WORKDIR /builder/frontend
RUN npm install \
    && npm run build


FROM clojure:temurin-23-lein-noble AS backend

WORKDIR /builder
COPY project.clj project.clj
COPY --from=frontend /builder/frontend/build resources/public
COPY src src
RUN lein ring uberjar


FROM eclipse-temurin:23-alpine

WORKDIR /app
COPY --from=backend /builder/target/uberjar/cv-creator.jar /app/cv-creator.jar
COPY data /app/data
# We need to minimize Java's memory footprint.
# Our host 'fly.io' has a limit of 256 MB of RAM for the free tier,
# and the instrumentation it adds takes around 155 MB!
ENTRYPOINT ["java", "-Xms32M", "-Xmx32M", "-jar", "/app/cv-creator.jar"]
