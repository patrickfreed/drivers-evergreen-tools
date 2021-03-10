#!/bin/bash

set -o errexit

${MONGODB_BINARIES}/mongo \
                   --eval "const mongodbUri = '${MONGODB_URI}';\
                           const taskId = '${task_id}'" \
                   release-db-lock.js
