# Kong Istio Gateway

    kubectl create namespace kong-istio
    kubectl label namespace kong-istio istio-injection=enabled
    helm repo add kong https://charts.konghq.com && helm repo update

    helm install -n kong-istio kong-istio kong/kong -f values.yaml

Sample `value.yaml` can be found here: https://github.com/samwang0723/jarvis/blob/main/deployments/helm/kong/values.yaml

## Kong Admin API & Manager tools
You can leverage the native built-in Kong manager https://docs.konghq.com/gateway/latest/#kong-manager 
Or using some alternatives like Konga (archived already) https://github.com/pantsel/konga

### Konga deployment
Save to values.yml, and do `kubectl apply -f values.yml`

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: konga
      namespace: kong-istio
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: konga
      template:
        metadata:
          labels:
            app: konga
        spec:
          containers:
            - name: konga
              image: pantsel/konga
              env:
                - name: DB_ADAPTER
                  value: 'postgres'
                - name: DB_HOST
                  value: 'kong-istio-postgresql.kong-istio.svc.cluster.local'
                - name: DB_PORT
                  value: '5432:5432'
                - name: DB_PASSWORD
                  value: 'kong'
                - name: DB_USER
                  value: 'kong'
                - name: DB_DATABASE
                  value: 'kongba'
              ports:
                - containerPort: 1337
                  name: web
    ---
    kind: Service
    apiVersion: v1
    metadata:
      name: konga
      namespace: kong-istio
    spec:
      type: ClusterIP
      ports:
       - name: http
         protocol: TCP
         port: 1337
         targetPort: 1337
      selector:
        app: konga
