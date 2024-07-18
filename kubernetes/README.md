# Kubernetes local environment
Use Orbstack https://orbstack.dev/ instead, better performance and resources usage compared to Docker or Rancher.

## k9s
K9s provides a terminal UI to interact with your Kubernetes clusters. The aim of this project is to make it easier to navigate, observe and manage your applications in the wild. K9s continually watches Kubernetes for changes and offers subsequent commands to interact with your observed resources. https://github.com/derailed/k9s

    brew install k9s
    k9s

## k3d/k3s Installation

    k3d cluster create --api-port 6550 -p "9080:80@loadbalancer"  -p "9443:443@loadbalancer" --agents 2 --k3s-arg '--disable=traefik@server:*'

    k3d cluster list
    kubectl config get-contexts
    kubectl config use-context k3d-k3s-default
    kubectl cluster-info
    kubectl get nodes

### (Option) if you want to build local image registry
Sometimes you just want build the image in local and use in k8s local environment, may not necessarily upload to dockerhub.

    k3d registry create registry.localhost --port 5000

Note: you will need to bind the image registry while creating the k3d cluster

    k3d cluster create --api-port 6550 -p "9080:80@loadbalancer"  -p "9443:443@loadbalancer" --agents 2 --k3s-arg '--disable=traefik@server:*' --registry-use k3d-registry.localhost:5000 --registry-config registries.yaml

The `registries.yml`

    mirrors:
        "localhost:5000":
            endpoint:
                - http://k3d-registry.localhost:5000

Upload built image (need to specify localhost:5000 while build docker image)

    docker push localhost:5000/{{image}}:{{version}}

## Recommend to use Istio service mesh
Istio extends Kubernetes to establish a programmable, application-aware network. Working with both Kubernetes and traditional workloads, Istio brings standard, universal traffic management, telemetry, and security to complex deployments.
https://istio.io/latest/docs/

    helm repo add istio https://istio-release.storage.googleapis.com/charts
    helm repo update

    kubectl create namespace istio-system
    helm install istio-base istio/base -n istio-system --wait
    helm install istiod istio/istiod -n istio-system --wait

    kubectl label namespace istio-system istio-injection=enabled
    kubectl label namespace default istio-injection=enabled

Remember to inject istio if you are creating new namespaces

    kubectl label namespace ${namespace} istio-injection=enabled

### Istio Monitoring
You can leverage Kiali to monitor and configure your istio. Kiali is a console for Istio service mesh. Kiali can be quickly installed as an Istio add-on, or trusted as a part of your production environment. 

    kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.12/samples/addons/prometheus.yaml
    kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.12/samples/addons/kiali.yaml

    istioctl dashboard kiali

## Uninstall

    k3d cluster delete k3s-default

## Secrets
Encode

    echo "token" | base64

Decode

    kubectl get secret --namespace default {{name}} -o jsonpath="{.data.{{key}}}" | base64 --decode ; echo

## Watch (no need if using k9s)

    brew install watch
    watch -n 1 kubectl get pods -n {namespace}
