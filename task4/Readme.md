The mock api app is based on python flask framework, start the flask mock api server
```
python  python ./mock_api.py
```

Test the mock api server with get method from the same server
```
curl  http://127.0.0.1:8100/wiredcraft/api/v1.0/mock_test
#Expected result
{
  "mock_test": "success"
}
```


To build the docker image
```
docker build -f Dockerfile -t wiredcraft/mockapi:v1 .  
```