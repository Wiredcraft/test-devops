build: fmt
	go build ./cmd/devops

fmt:
	go fmt ./...

test:
	go test ./...

bin:
	gox -osarch="linux/amd64 linux/386 linux/arm darwin/amd64 windows/386 windows/amd64" ./cmd/devops
