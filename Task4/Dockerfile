FROM golang:1.17 AS builder
WORKDIR /go/
COPY hello.go init.go db.go go.mod go.sum ./
RUN unset GOPATH && CGO_ENABLED=0 go build

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /go/hello .
COPY config.yaml ./
CMD ["./hello"]
EXPOSE 9090