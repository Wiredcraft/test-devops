FROM golang:1.16-alpine AS build-env
#RUN apk add ca-certificates upx
RUN apk add upx # use upx to compress bin file
ADD . /mockapi/
RUN cd /mockapi \
    && CGO_ENABLED=0 GOOS=linux go build -ldflags "-s -w" -o mockapi mockapi.go \
    && upx -9 mockapi

FROM scratch
COPY --from=build-env /mockapi/mockapi /
#COPY --from=build-env /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
EXPOSE 8080
ENTRYPOINT ["/mockapi"]
