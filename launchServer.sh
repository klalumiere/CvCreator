#! /usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

docker build --pull --tag cvcreator .
docker run --interactive --publish 8080:8080 --tty cvcreator
