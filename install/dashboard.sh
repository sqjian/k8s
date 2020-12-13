#!/usr/bin/env bash

set -eux


# dashboard
# https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
grep image yaml/recommended.yml |uniq

docker pull kubernetesui/dashboard:v2.0.0
docker pull kubernetesui/metrics-scraper:v1.0.4

# # kubectl delete -f yaml/kube-flannel.yml
kubectl apply -f yaml/recommended.yml

# 创建dashboard管理用户
kubectl create serviceaccount dashboard-admin -n kube-system
# 绑定用户为集群管理用户
kubectl create clusterrolebinding dashboard-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:dashboard-admin
# 获取tocken
kubectl describe secret -n kube-system dashboard-admin-token-l7kpn


kubectl proxy --address='0.0.0.0' --port=80
# http://127.0.0.1:80/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/