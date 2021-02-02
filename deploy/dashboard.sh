#!/usr/bin/env bash

set -eux


grep image yaml/recommended.yml |uniq

docker pull kubernetesui/dashboard:v2.0.0
docker pull kubernetesui/metrics-scraper:v1.0.4

# kubectl delete -f yaml/kube-flannel.yml
kubectl apply -f yaml/recommended.yml

# kubectl proxy --address='0.0.0.0' --port=80
# http://127.0.0.1:80/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/