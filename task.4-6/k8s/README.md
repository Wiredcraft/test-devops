# Task 5. Kubernetes

NOTE: I am using kubernetes v1.19.7, so you are expected to have a compatiable
cluster to run the kubernetes resources here.

## How to run

You can use the following command to create all 3 resource at once:

```bash
kubectl create -f deployment.yaml -f service.yaml -f hpa.yaml
```

## Optional

For easy to get started, you can use the `kubectl` to create the these
kubernetes resources imperatively:

```bash
# Deployment
kubectl create deployment mocker --image=wiredcraft/mocker:latest --port=3000

# Service
kubectl expose deployment/mocker --port=30 --target-port=3000

# HorizontalPodAutoscaler
kubectl autoscale deployment/mocker --min=2 --max=5 --cpu-percent=80
```
