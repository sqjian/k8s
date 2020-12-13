#!/usr/bin/env bash

set -eux


# cni
# https://raw.githubusercontent.com/coreos/flannel/v0.13.0/Documentation/kube-flannel.yml
# grep image yaml/kube-flannel.yml |uniq
aliyuncs_image=registry.cn-hangzhou.aliyuncs.com/google_imags_kubernetes/flannel:v0.13.0
docker pull ${aliyuncs_image}
docker tag ${aliyuncs_image} quay.io/coreos/flannel:v0.13.0
# kubectl delete -f yaml/kube-flannel.yml
kubectl apply -f yaml/kube-flannel.yml