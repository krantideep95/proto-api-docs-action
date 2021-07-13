# proto api docs action

This action clones protobuf files from a (public/private) github repository, generate swagger v2.0 api docs using buf & grpc-gateway's [protoc-gen-openapiv2](https://github.com/grpc-ecosystem/grpc-gateway/tree/master/protoc-gen-openapiv2) plugin, and finally upload the generated documentation to aws S3.

## Inputs

### GIT_TOKEN:

**Required** git token to use for cloning the repository containing the protobuf files

### PROTO_REPOSITORY:

**Required** protobuf files github repository including the org name

### PROTO_BRANCH:

**Required** branch to clone

### MODULE_LIST_FILE_PATH:

**Required** path to file containing list of subdirectories of protos to clone

### AWS_S3_BUCKET:

**Required** s3 bucket name

### AWS_ACCESS_KEY_ID:

**Required** aws access key id

### AWS_SECRET_ACCESS_KEY:

**Required** aws access key secret

### AWS_REGION:

**Required** aws region

### SOURCE_DIR:

**Required** source directory

### DEST_DIR:

**Required** destination s3 directory

## Outputs
NA

## Example usage
```yaml
- uses: actions/checkout@v2
- uses: krantideep95/proto-api-docs-action@master
  with:
    GIT_TOKEN: ${{ secrets.GIT_TOKEN }}
    PROTO_REPOSITORY: krantideep95/proto
    PROTO_BRANCH: test
    MODULE_LIST_FILE_PATH: scripts/proto_modules
    AWS_S3_BUCKET: apidocs
    AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
    AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    AWS_REGION: ap-south-1
    SOURCE_DIR: /_docs
    DEST_DIR: _docs
```
