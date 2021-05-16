FROM golang:1.16 AS builder
WORKDIR /go/
COPY mocker.go go.mod  .
RUN unset GOPATH && CGO_ENABLED=0 go build

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/mocker .
CMD ["./mocker"]
EXPOSE 3000
