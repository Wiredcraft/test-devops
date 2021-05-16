help:
	@echo "There are 4 targets avaliable:"
	@echo "  docker : build and tag our image"
	@echo "  test   : start mock server and do some curl for testing"
	@echo "  clean  : stop mock server"
	@echo "  push   : push image to docker hub (user wiredcraft)"

docker:
	@docker build -t wiredcraft/mocker:latest .

push:
	@docker push wiredcraft/mocker:latest

test:
	@docker run --name=mocker -d -p 3000:3000 wiredcraft/mocker:latest
	@curl http://localhost:3000/counter
	@curl http://localhost:3000/counter
	@curl http://localhost:3000/counter

clean:
	@docker stop mocker
	@docker rm mocker
