FROM mirror.gcr.io/library/golang:1.16-alpine

RUN apk add make git curl bash jq aws-cli

RUN go get github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@v2.5.0 google.golang.org/protobuf/cmd/protoc-gen-go@v1.26.0

RUN curl -sSL \
	"https://github.com/bufbuild/buf/releases/download/v0.43.2/buf-Linux-x86_64" \
	-o "$(go env GOPATH)/bin/buf" && \
	chmod +x "$(go env GOPATH)/bin/buf"

COPY . /

ENTRYPOINT [ "/entrypoint.sh" ]
