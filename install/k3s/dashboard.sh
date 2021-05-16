#!/usr/bin/env bash

set -eux


grep image recommended.yml |uniq

docker pull kubernetesui/dashboard:v2.0.0
docker pull kubernetesui/metrics-scraper:v1.0.4

kubectl apply -f yaml/recommended.yml