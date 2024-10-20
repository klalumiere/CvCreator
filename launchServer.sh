#! /usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

docker build --pull --tag cvcreator .
# The memory limit mimics fly.io 's free tier memory limit.
docker run \
    --env CV_CREATOR_DATA_DIR_PATH="data/sample" \
    --interactive \
    --memory 200M \
    --publish 8080:8080 \
    --tty \
    cvcreator
