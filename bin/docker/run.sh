#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source $(dirname "${BASH_SOURCE[0]}")/vars.sh

function help() {
  echo "Usage: bin/test.sh [ENV]"
  echo "ENV can be: DEV, QA, PROD"
  printf "\n"
}

# Display usage information if incorrect args are provided.
if [[ $# -lt 1 ]]; then
  help
  exit 1
fi

ENV=$1

docker run --rm \
  --name $PACKAGE_NAME \
  --volume "$(pwd)/results:/results" \
  $IMAGE_NAME bin/test.sh $ENV

