#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Display usage information if no ENV is provided.
if [[ $# -eq 0 ]]; then
  echo "Usage: bin/test.sh [ENV]"
  echo "ENV can be: DEV, QA, PROD"
  exit 1
fi

ENV=$1
TEST=1

rm -rf ./results
mkdir results || true

# It would be possible to have different types of tests in this repository.
# If you created another directy named `go-tests`, you could also run those tests from here.
function run_cypress_tests () {
  (
    cd cypress-tests

    export NODE_ENV=$ENV
    npm run test:tap -- $@ 2>&1 | tee ./../results/test-results-$TEST.tap
  )
  TEST=$(($TEST + 1))
}

# Run a different set of tests depending on ENV.
# The export VAR=value pattern lets us configure the environment as well.
if [[ $ENV == "DEV" ]]; then

  run_cypress_tests

elif [[ $ENV == "QA" ]]; then

  run_cypress_tests

elif [[ $ENV == "PROD" ]]; then

  run_cypress_tests

else

  echo "Invalid or unconfigured ENV provided."
  exit 1

fi

exit 0