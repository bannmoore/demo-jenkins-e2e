#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source $(dirname "${BASH_SOURCE[0]}")/vars.sh

$(dirname "${BASH_SOURCE[0]}")/stop.sh || true

docker image rm $IMAGE_NAME
docker image rm node:10.15.0
