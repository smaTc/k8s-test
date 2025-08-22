#!/bin/bash

kind delete cluster
kind create cluster --config cluster.yaml
docker pull registry.k8s.io/e2e-test-images/agnhost:2.39
kind load docker-image registry.k8s.io/e2e-test-images/agnhost:2.39

kubectl apply -f test-setup.yaml

LB_IP=$(kubectl get svc/foo-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
alias test=$(curl $LB_IP:5678)

