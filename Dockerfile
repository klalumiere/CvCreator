FROM node:24-bookworm AS frontend

COPY frontend /builder/frontend
WORKDIR /builder/frontend
RUN npm install --global pnpm \
    && pnpm install --frozen-lockfile \
    && pnpm build


FROM clojure:temurin-23-lein-noble AS backend

WORKDIR /builder
COPY backend/project.clj project.clj
COPY backend/src src
COPY --from=frontend /builder/frontend/dist resources/public
RUN lein uberjar


FROM eclipse-temurin:23-alpine

WORKDIR /app
COPY --from=backend /builder/target/uberjar/cv-creator.jar /app/cv-creator.jar
COPY data /app/data
# The machine we chose on our host 'fly.io' has a limit of 256 MB of RAM,
# of which the kernel reserves around 40 MB and the 'fly.io' SSH agent takes around 20 MB.
# Stopping at C1 (`TieredStopAtLevel=1`) keeps the code cache small; peak throughput doesn't matter here.
ENTRYPOINT ["java", \
    "-Xmx48M", \
    "-Xss512k", \
    "-XX:TieredStopAtLevel=1", \
    "-XX:ReservedCodeCacheSize=24M", \
    "-XX:MaxMetaspaceSize=64M", \
    "-jar", "/app/cv-creator.jar"]
