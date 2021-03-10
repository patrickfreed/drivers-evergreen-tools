#!/bin/bash

set -o errexit

${MONGODB_BINARIES}/mongo \
                   --eval "const mongodbUri = '${MONGODB_URI}'; \
                           const author = '${author}'; \
                           const project = '${project}'; \
                           const taskId = '${task_id}'; \
                           const createdAt = '${created_at}';" \
                   acquire-db-lock.js
