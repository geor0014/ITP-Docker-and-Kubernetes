# 15 - Managing Data in Kubernetes

## Understanding ‘State’

![1.png](15%20-%20Managing%20Data%20in%20Kubernetes%20b51425d2b47140efa62781c665753a36/1.png)

### The Solution

![1.png](15%20-%20Managing%20Data%20in%20Kubernetes%20b51425d2b47140efa62781c665753a36/1%201.png)

---

## Kubernetes and Volumes

![1.png](15%20-%20Managing%20Data%20in%20Kubernetes%20b51425d2b47140efa62781c665753a36/1%202.png)

### Kubernetes Volumes VS Docker Volumes

![1.png](15%20-%20Managing%20Data%20in%20Kubernetes%20b51425d2b47140efa62781c665753a36/1%203.png)

## Creating a new Deployment file

- create a `.yaml` file

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: story-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: story
  template:
    metadata:
      labels:
        app: story
    spec:
      containers:
       - name: story
        image: georgiev098/kub-data-demo
```

---

## Kubernetes Volumes

[Volumes](https://kubernetes.io/docs/concepts/storage/volumes/)

### Defining volumes in the `.yaml`file

```yaml
containers:
       - name: story
        image: georgiev098/kub-data-demo
        **volumeMounts:
          - mountPath: /app/story
            name: story-data
      volumes:
        - name: story-data
          emptyDir: {}**
```

## Persistent volumes

![1.png](15%20-%20Managing%20Data%20in%20Kubernetes%20b51425d2b47140efa62781c665753a36/1%204.png)

## Volumes VS Persistent Volumes

### Normal Volumes

![1.png](15%20-%20Managing%20Data%20in%20Kubernetes%20b51425d2b47140efa62781c665753a36/1%205.png)

### Persistent Volumes

![1.png](15%20-%20Managing%20Data%20in%20Kubernetes%20b51425d2b47140efa62781c665753a36/1%206.png)

## Create a Persistent Volume

- create a `host-pv.yaml`

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: host-pv
spec:
  capacity:
    storage: 1Gi
  volumeMode: Filesystem
	storageClassName: standard
  accessMode:
    - ReadWriteOnce
  hostPath:
    path: /data
    type: DirectoryOrCreate
```

### Creating a Persistent Volume Claim

- create a `host-pvc.yaml`

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: host-pvc
spec:
  volumeName: host-pv
  accessModes:
    - ReadWriteOnce
	storageClassName: standard
  resources:
    requests:
      storage: 1Gi
```

- Connect the two files
    - In the file (`deployment.yaml`) you add:

```yaml
volumes:
        - name: story-data
        persistentVolumeClaim:
          claimName: host-pvc
```

---

## Using Environments Variables

Go to `deployment.yaml`

```yaml
containers:
        - name: story
        image: georgiev098/kub-data-demo
        **env:
          - name: VARIABLE_NAME
            value: "value"**
```

<aside>
💡 If you want to have your variables in a different file you can utilize **Kubernetes `ConfigMaps`**

</aside>

[ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/)

---

## Volumes VS Persistent Volumes

![1.png](15%20-%20Managing%20Data%20in%20Kubernetes%20b51425d2b47140efa62781c665753a36/1%207.png)