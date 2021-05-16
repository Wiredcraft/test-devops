# Task 4. Docker and a bit of Dev

In this task, I write a simple golang (1.6+) http server that will response http
request counts since the server starts. You can test the service on localhost (I
assumed that you have go1.6+ installed) by the following steps:

```bash
$ go run wiredcraft.com/mocker
$ curl -v localhost:3000/counter
```

For containerization, I use the docker multi-stage build technology to build our
mocker service using go1.6+ docker base image, but run our mocker service using
a smaller and lightweighted apline base image.

I also wrap all steps into one Makefile to help you quick start and run. More
details please run `make` or `make help`.
