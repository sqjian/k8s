#!/usr/bin/env bash

set -eux

# kubectl delete -f yaml/kube-flannel.yml
kubectl apply -f yaml/kube-flannel.yml