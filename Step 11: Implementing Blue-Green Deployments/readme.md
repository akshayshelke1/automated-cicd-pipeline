# Define Kubernetes manifests for blue-green deployment:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: user-service-green
spec:
  replicas: 3
  selector:
    matchLabels:
      app: user-service
      version: green
  template:
    metadata:
      labels:
        app: user-service
        version: green
    spec:
      containers:
      - name: user-service
        image: <aws_account_id>.dkr.ecr.us-west-2.amazonaws.com/user-service:green
        ports:
        - containerPort: 8080
```

# Apply the green deployment and switch traffic using Istio:

```bash
kubectl apply -f k8s/user-service-green.yaml
kubectl apply -f k8s/virtualservice.yaml
```
