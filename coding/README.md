# Coding necessary Installation & Tools

## pre-commit

    pip3 install pre-commit

## Rust

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

### Update Rust

    rustup update

### Create new project

    cargo new {{project}}

## Golang

    go install golang.org/x/vuln/cmd/govulncheck@latest
    go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest
    go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

Database migration

    brew install golang-migrate
    go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
    migrate create -ext sql -dir database/migrations -tz Asia/Taipei {{name}}

Upgrade `interface{}` to generic `any`

    gofmt -w -r 'interface{} -> any' ./..

## Postgresql

    brew install libpq
    sudo ln -s $(brew --prefix)/opt/libpq/bin/psql /usr/local/bin/psql

## Simple HTTP server to serve files locally

    python -m http.server

## Kafka

    /opt/bitnami/kafka/bin/kafka-topics.sh --bootstrap-server kafka:9092 --list
    /opt/bitnami/kafka/bin/kafka-topics.sh --bootstrap-server kafka:9092 --create --topic {{topic}} --replication-factor 1 --partitions 1

## Port being taken after program shutdown unexpected

    sudo lsof -i tcp:{{port}}
