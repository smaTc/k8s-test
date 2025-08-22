#!/bin/bash

LB_IP=$(kubectl get services --namespace ingress-nginx ingress-nginx-controller --output jsonpath='{.status.loadBalancer.ingress[0].ip}')
curl $LB_IP/api