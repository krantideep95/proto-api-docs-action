#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

mkdir -p /proto
cd /proto
git init
git config --local gc.auto 0
git config core.sparseCheckout true
GIT_TOKEN=$INPUT_GIT_TOKEN
cp $GITHUB_WORKSPACE/${INPUT_MODULE_LIST_FILE_PATH} .git/info/sparse-checkout
git remote add origin https://${INPUT_GIT_TOKEN}@github.com/${INPUT_PROTO_REPOSITORY}
git -c protocol.version=2 fetch --no-tags --prune --progress --depth=1 origin ${INPUT_PROTO_BRANCH}
git checkout --progress --force -B ${INPUT_PROTO_BRANCH} origin/${INPUT_PROTO_BRANCH}

cd /
