# 16 - Kubernetes Networking

## What we are building

![1.png](16%20-%20Kubernetes%20Networking%20d33424fd8bd647d2a9257cc460264e3e/1.png)

- Creating a Deployment
    - Create a `users-deployment.yaml`file

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: users-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: users
  template:
    metadata:
      labels:
        app: users
    spec:
      containers:
        - name: users
          image: georgiev098/kub-networking
```

- Adding Services
    - create a `users-service.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: users-service
spec:
  selector:
    app: users
  type: LoadBalancer
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 8080
```

- Add the auth container to the `users-deployment.yaml`

```yaml
containers:
        - name: users
          image: georgiev098/kub-networking:latest
        - name: auth
          image: georgiev098/kub-auth:latest
```

What we have so far

![1.png](16%20-%20Kubernetes%20Networking%20d33424fd8bd647d2a9257cc460264e3e/1%201.png)

- Creating Multiple Deployments
    - Create `auth-deployment.yaml`
    
    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: auth-deployment
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: auth
      template:
        metadata:
          labels:
            app: auth
        spec:
          containers:
            - name: users
              image: georgiev098/kub-networking:latest
    ```
    
    - Create `auth-service.yaml`
    
    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: auth-service
    spec:
      selector:
        app: auth
      type: ClusterIP
      ports:
        - protocol: TCP
          port: 80
          targetPort: 80
    ```