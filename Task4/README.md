# Description
In this task, I write a simple API service with golang. 
The API has two endpoints for welcome message:
- `GET /welcome` returns `Hello, <name>!`, if not exist name then returns  `Hello, Wiredcraft!`,if the name cache exist , then don't query from database 
- `PUT /welcome` with body `{"name": "<name>"}`, which changes the name string.


I split the whole project into the following files：
```
Task4
├── Dockerfile  // Dockerfile to containerize this API
├── README.md
├── config.yaml // The configuration of redis needs to be encrypted in the production environment.
├── db.go // Connect to redis, get key and set key
├── go.mod
├── go.sum
├── hello.go // Handling get and put requests
├── init.go // Get config from config.yaml
└── openapi.json //  An API Spec
```

# Environment
- Docker version 20.10.12
- go version 1.17.5

# Prerequisites
Use an existing redis server or  create a [redis instance](https://hub.docker.com/_/redis)with docker for testing.
Then modify the value in config.yaml :
```yaml
redis:
    addr:  # ip:port
    passWord: # redis password
    dataBase: 0 # Default Database
```

# Quick Start

### Run in local
```bash
# Build
go build
# Run 
./hello
```

```
# Test get method
curl --request GET 'http://127.0.0.1:9090/welcome'
# Test put method
curl --location --request PUT 'http://127.0.0.1:9090/welcome' --data-raw '{"name": "name"}'
```

### Run as a container
Build and tag image
```bash
docker build -t wiredcraft/hello:latest . 
```
Start server
```bash
docker run --name=hello -it -p 9090:9090 wiredcraft/hello:latest
```
Other 
```bash
# stop server
docker stop hello
# delete container
docker rm hello
```