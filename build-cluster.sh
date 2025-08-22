#!/bin/bash

kind delete cluster
kind create cluster --config cluster.yaml
# docker pull registry.k8s.io/e2e-test-images/agnhost:2.39
# kind load docker-image registry.k8s.io/e2e-test-images/agnhost:2.39

docker pull gcr.io/google-samples/kubernetes-bootcamp:v1
kind load docker-image gcr.io/google-samples/kubernetes-bootcamp:v1

kubectl apply -f bootcamp-pod.yaml
kubectl apply -f bootcamp-service.yaml

# kubectl apply -f bootcamp-loadbalancer.yaml

kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
kubectl apply -f bootcamp-ingress.yaml

echo "waiting for cluster to assign ingress IPs..."
sleep 10

./response-test.sh

# LB_IP=$(kubectl get services --namespace ingress-nginx ingress-nginx-controller --output jsonpath='{.status.loadBalancer.ingress[0].ip}')

# curl $LB_IP/api
