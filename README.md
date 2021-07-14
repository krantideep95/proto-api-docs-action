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

### DEST_DIR:

**Required** destination s3 directory

another directory will be created in the destination directory with the name of the repository running this action. The generated documentation will be uploaded to this directory with branch name as the name of the file.

## Outputs
NA

## Example usage
```yaml
- uses: actions/checkout@v2
- uses: krantideep95/proto-api-docs-action@v0.2.0
  with:
    GIT_TOKEN: ${{ secrets.GIT_TOKEN }}
    PROTO_REPOSITORY: krantideep95/proto
    PROTO_BRANCH: test
    MODULE_LIST_FILE_PATH: scripts/proto_modules
    AWS_S3_BUCKET: apidocs
    AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
    AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    AWS_REGION: ap-south-1
    DEST_DIR: _docs
```

## FAQs

### Will it work with twirp?

Short Answer: Yes, with a few quirks.

Long Answer: proto-gen-openapiv2 plugin is meant to be used with grpc-gateway protobuf files. It is not meant to be used with twirp. twirp officially doesn't support a plugin to generate swagger api docs. By enabling a few options in plugin, this action can be used to generate swagger api docs for twirp. You can use following proto definitions in one of the files to make this compatible with twirp:
```protobuf
import "protoc-gen-openapiv2/options/annotations.proto";

option (grpc.gateway.protoc_gen_openapiv2.options.openapiv2_swagger) = {
  schemes: HTTPS;
  host: "base url";
  base_path: "/twirp/";
  security: {
    security_requirement :{
      key: "BasicAuth";
      value: {};
    }
  }
  security_definitions: {
    security: {
      key: "BasicAuth";
      value: {
        type: TYPE_BASIC;
      }
    }
}
};
```

### Should this be used in a common protobuf repo or different backend service specific repos ?

Usually, 1 backend service exposes different sub-domains' APIs in 1 deployment. For such cases, it makes sense to use this action separately in that backend service's repo.
