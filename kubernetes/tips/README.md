# Some tips while using kubernetes

## Decode secret

    kubectl get secret --namespace default {{name}} -o jsonpath="{.data.{{key}}}" | base64 --decode ; echo

## Quick check to your k8s redis

    kubectl run redis-client --rm -it --image=redis -- bash
    redis-cli -u redis://{{service-name}}.default.svc.cluster.local:6379

## Debugging with cURL
First, to create values.yml

    apiVersion: v1
    kind: Pod
    metadata:
      name: curlpod
      namespace: default
    spec:
      containers:
      - name: curlcontainer
        image: curlimages/curl:latest
        command: ["sleep", "3600"]

and apply the pod deployment

    kubectl apply -f values.yml

then run the curl query to your other services

    kubectl exec -it curlpod -- curl -v {{url}}

## Rollout

    kubectl rollout restart deployment {{name}}

## Shutdown

    kubectl scale statefulsets {{name}} --replicas=2
