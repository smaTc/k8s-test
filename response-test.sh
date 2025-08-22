#!/bin/bash

export LB_IP=$(kubectl get services --namespace ingress-nginx ingress-nginx-controller --output jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo "service ip: ${LB_IP}"

for i in {1..30}
do
    curl $LB_IP/api
    sleep 1
done