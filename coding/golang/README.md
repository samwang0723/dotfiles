# Golang

## Fresh install

```bash
# Download the latest version of Go
curl -LO https://golang.org/dl/go$(curl -s https://golang.org/VERSION?m=text).darwin-amd64.tar.gz

# Extract the archive
sudo tar -C /usr/local -xzf go$(curl -s https://golang.org/VERSION?m=text).darwin-amd64.tar.gz

# Add Go to the PATH
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.zshrc

# Apply the changes to the current shell session
source ~/.zshrc

# Verify the installation
go version
```

While downloading a project, make sure to run below first to install necessary packages
```bash
go mod tidy
go mod download
```

## Security

    brew install trivy
    go install golang.org/x/vuln/cmd/govulncheck@latest

## grpc-gateway
The gRPC-Gateway is a plugin of the Google protocol buffers compiler protoc. It reads protobuf service definitions and generates a reverse-proxy server which translates a RESTful HTTP API into gRPC. This server is generated according to the google.api.http annotations in your service definitions.
https://github.com/grpc-ecosystem/grpc-gateway

    brew install protobuf

    go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest
    go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

## Database migration
Prefer using sqlc for type-safe database operation handling, using Gorm also can.
migrate with `-tz` will convert the migration file prefix with timestamp.

    brew install golang-migrate
    go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
    migrate create -ext sql -dir database/migrations -tz Asia/Taipei {{name}}

Upgrade `interface{}` to generic `any` for legacy code migration

    gofmt -w -r 'interface{} -> any' ./..

## Project layout

https://github.com/golang-standards/project-layout

## Swagger

https://www.cnblogs.com/catcher1994/p/11869532.html

https://blog.csdn.net/boling_cavalry/article/details/111406857

https://github.com/moby/moby/tree/master/api
