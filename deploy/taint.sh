#!/usr/bin/env bash

set -eux

# 解除 master 节点默认不能运行 pod
kubectl taint nodes --all node-role.kubernetes.io/master-
# 恢复默认值
# $ kubectl taint nodes NODE_NAME node-role.kubernetes.io/master=true:NoSchedule