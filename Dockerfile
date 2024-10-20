FROM node:20-bookworm AS frontend

COPY frontend /builder/frontend
WORKDIR /builder/frontend
RUN npm install \
    && npm run build


FROM clojure:temurin-21-lein-noble AS backend

WORKDIR /builder
COPY project.clj project.clj
COPY --from=frontend /builder/frontend/build resources/public
COPY src src
RUN lein ring uberjar


FROM gcr.io/distroless/java21-debian12

WORKDIR /app
ENV JAVA_TOOL_OPTIONS="-Xmx32M"
COPY --from=backend /builder/target/uberjar/cv-creator.jar /app/cv-creator.jar
COPY data /app/data
CMD ["/app/cv-creator.jar"]
