#!/bin/sh
set -o xtrace   # Write all commands first to stderr
set -o errexit  # Exit the script with error if any of the commands fail

ID=$(python -c 'import sys, json; j=json.load(open("tmp.json")); print(j["id"])' | tr -d '\r')
. ${DRIVERS_TOOLS}/.evergreen/orchestration-config.sh

curl --silent --show-error --max-time 600 --fail --request DELETE "$ORCHESTRATION_URL/$ID"
