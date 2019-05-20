#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source $(dirname "${BASH_SOURCE[0]}")/vars.sh

docker build --tag $IMAGE_NAME .