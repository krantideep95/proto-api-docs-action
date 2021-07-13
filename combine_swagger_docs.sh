#!/bin/bash
set -euo pipefail

# find all swagger jsons
files=$(find "$1" -type f -iname "*swagger.json")

# delete old combined file
rm -rf combined.json
echo "{}" > combined.json

# iterate over all files & append to combined.json
for file in $files
do
  j=$(jq -s '.[0] * .[1]' combined.json "$file")
  echo "$j" > combined.json
done

## append empty swagger file to override title, tags with empty values
echo '{ "swagger": "2.0", "info": { "title": "", "version": "v1" }, "tags": [ { "name": "." } ], "paths": {}, "definitions": {} }' > last.json

j=$(jq -s '.[0] * .[1]' combined.json last.json)
echo "$j" > combined.json
