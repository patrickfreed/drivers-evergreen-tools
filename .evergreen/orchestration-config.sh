#!/bin/sh

AUTH=${AUTH:-noauth}
SSL=${SSL:-nossl}
TOPOLOGY=${TOPOLOGY:-server}
STORAGE_ENGINE=${STORAGE_ENGINE}
# Set to a non-empty string to use the <topology>/disableTestCommands.json
# cluster config, eg DISABLE_TEST_COMMANDS=1
DISABLE_TEST_COMMANDS=${DISABLE_TEST_COMMANDS}
MONGODB_VERSION=${MONGODB_VERSION:-latest}

ORCHESTRATION_FILE="basic"
if [ "$AUTH" = "auth" ]; then
  ORCHESTRATION_FILE="auth"
fi

if [ "$SSL" != "nossl" ]; then
   ORCHESTRATION_FILE="${ORCHESTRATION_FILE}-ssl"
fi

# disableTestCommands files do not exist for different auth or ssl modes.
if [ ! -z "$DISABLE_TEST_COMMANDS" ]; then
  ORCHESTRATION_FILE="disableTestCommands"
fi

# Storage engine config files do not exist for different auth or ssl modes.
if [ ! -z "$STORAGE_ENGINE" ]; then
  ORCHESTRATION_FILE="$STORAGE_ENGINE"
fi

export ORCHESTRATION_FILE="$MONGO_ORCHESTRATION_HOME/configs/${TOPOLOGY}s/${ORCHESTRATION_FILE}.json"
export ORCHESTRATION_URL="http://localhost:8889/v1/${TOPOLOGY}s"
