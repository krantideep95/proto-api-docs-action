#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

ls $GITHUB_WORKSPACE

mkdir -p protos
cd protos

git init
git config --local gc.auto 0
git config core.sparseCheckout true
cp $GITHUB_WORKSPACE/${MODULE_LIST_FILE_PATH} .git/info/sparse-checkout
git remote add origin https://github.com/${GIT_URL}
git -c protocol.version=2 fetch --no-tags --prune --progress --depth=1 origin ${PROTO_BRANCH}
git checkout --progress --force -B ${PROTO_BRANCH} origin/${PROTO_BRANCH}

ls $GITHUB_WORKSPACE
ls $GITHUB_WORKSPACE/protos
