#!/usr/bin/env bash

set -eux

kubectl label node slave1 node-role.kubernetes.io/worker=worker
kubectl label node slave2 node-role.kubernetes.io/worker=worker