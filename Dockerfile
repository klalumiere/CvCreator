FROM eclipse-temurin:23-alpine AS base

RUN apk add --no-cache tini


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
ENTRYPOINT ["/sbin/tini", "-s", "--"]
CMD ["java", "-Xmx64M", "-jar", "/app/cv-creator.jar"]
