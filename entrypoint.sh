#!/bin/bash
set -euo pipefail

echo "cloning protobuf files"
bash /sparse-checkout.sh

echo "generating swagger docs"
cd / && buf beta mod update && buf generate

echo "combining swagger docs into 1 file"
bash /combine_swagger_docs.sh /docs

echo "create repo/branch dir structure"
mkdir -p /_docs/${GITHUB_REPOSITORY#*/} && mv combined.json /_docs/${GITHUB_REPOSITORY#*/}/${GITHUB_REF##*/}.json


echo "upload to s3"
bash /upload_to_s3.sh
