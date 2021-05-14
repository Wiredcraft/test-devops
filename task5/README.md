## Deploy Mock API Server to Kubernetes

To deploy the Mock API server, simply run

```sh
kubectl apply -f .
```

### Test

To test if the Mock API server works properly, forward
service port to the local host

```sh
kubectl port-forward svc/mock-api-server 3000
```

Test the API services using `curl`

```sh
curl -X POST -H 'Content-Type: application/json' -d '{"name":"joe", "age":20}' http://localhost:3000/api/users
curl http://localhost:3000/api/users
```

To test if HPA works, login into the pod

```sh
kubectl get pod
kubectl exec -it mock-api-server-5bb6d4bb45-kwx84 -- sh
```

and increase its CPU usage

```sh
yes > /dev/null
```

### Cleanup

To clean up everything, simply run

```sh
kubectl delete -f .
```
