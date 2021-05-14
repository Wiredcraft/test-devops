## Containerize Mock API Server

### Mock API Server

The API server is written in Node.js using Express framework.

It exposes the following API endpoints:

| API endpoint  | Method | Description    |
| ------------- | ------ | -------------- |
| /api/users    | GET    | List all users |
| /api/users    | POST   | Add new user   |
| /api/user/:id | GET    | Get user       |
| /api/user/:id | PUT    | Update user    |
| /api/user/:id | DELETE | Delete user    |

### Unit Tests and CI

Unit tests have been written, and Github Actions has been setup
`https://github.com/joekyo/mock-api-server/actions`.

When there is push event, Github Actions will run those unit
tests and send notification email if there was test failed.

### Run It in Docker

To create Docker image, run `docker build -t mock-api-server .`.

I've created and upload the image to Dockerhub.

To test how it works, run `docker run -d -p 3000:3000 joekyo/mock-api-server:v1`.

```sh
$ curl http://localhost:3000/api/users
{"users":[]}

$ curl -X POST -H 'Content-Type: application/json' -d '{"name":"joe", "age":20}' http://localhost:3000/api/users
{"name":"joe","age":20,"id":"d7793a8bf8f"}

$ curl http://localhost:3000/api/users
{"users":[{"name":"joe","age":20,"id":"d7793a8bf8f"}]}
```
