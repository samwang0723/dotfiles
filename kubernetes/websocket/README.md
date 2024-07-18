# Websocket

*Install websocket cli client* https://github.com/vi/websocat

```go
brew install websocat
```

Upgrade Ingress

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  # ... other properties
  annotations:
    konghq.com/headers.Connection: "Upgrade"
    konghq.com/headers.Upgrade: "WebSocket"
   ...
```

【kong websocket 负载均衡 -  CSDN App】http://t.csdnimg.cn/2XmcD

https://docs.konghq.com/hub/kong-inc/websocket-validator/

```yaml
curl -d "request_path=/&strip_request_path=true&upstream_url=http://127.0.0.1:5678" http://127.0.0.1:8001/apis/
curl -d "request_path=/api2&strip_request_path=true&upstream_url=http://127.0.0.1:8004" http://127.0.0.1:8001/apis/
curl -d "request_path=/api3&strip_request_path=true&upstream_url=http://127.0.0.1:8005" http://127.0.0.1:8001/apis/
```

```yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: TCPRoute
metadata:
 name: echo-plaintext
 namespace: echo
spec:
 parentRefs:
 - name: kong
   sectionName: stream5678
 rules:
 - backendRefs:
   - name: http-echo
     port: 5678
---
apiVersion: configuration.konghq.com/v1beta1
kind: TCPIngress
metadata:
  name: echo-plaintext
  namespace: echo
  annotations:
    kubernetes.io/ingress.class: kong
spec:
  rules:
  - port: 5678
    backend:
      serviceName: http-echo
      servicePort: 5678

```

https://docs.konghq.com/gateway/latest/how-kong-works/routing-traffic/#websocket-proxy-modes
