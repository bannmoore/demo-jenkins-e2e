#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

(
  cd js-tests
  npm install
)