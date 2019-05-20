#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

(
  cd cypress-tests

  rm -rf package-lock.json

  npm install
)