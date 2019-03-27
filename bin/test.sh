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
function run_js_tests () {
  (
    cd js-tests

    export NODE_ENV=$ENV
    npm run test -- $@ 2>&1 | tee ./../results/test-results-$TEST.tap
  )
  TEST=$(($TEST + 1))
}

# Run a different set of tests depending on ENV.
# The export VAR=value pattern lets us configure the environment as well.
if [[ $ENV == "DEV" ]]; then

  export SUITE=smoke
  run_js_tests "--grep" "smoke"

elif [[ $ENV == "QA" ]]; then

  # In this environment, we're running smoke and functional tests.

  export SUITE=smoke
  run_js_tests "--grep" "smoke"
  export SUITE=functional
  run_js_tests "--grep" "functional"

elif [[ $ENV == "STAGING" ]]; then

  export SUITE=ui
  run_js_tests "--grep" "ui"

elif [[ $ENV == "FAIL" ]]; then

  # If the smoke tests fail, the functional tests won't run, which saves time.

  export SUITE=wrong
  run_js_tests "--grep" "smoke"
  export SUITE=functional
  run_js_tests "--grep" "functional"

else

  echo "Invalid or unconfigured ENV provided."
  exit 1

fi

exit 0