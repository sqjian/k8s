#!/usr/bin/env bash

set -eux

apt-get update && apt-get install -y apt-transport-https
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
tee /etc/apt/sources.list.d/kubernetes.list <<- EOF
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF

swapoff -a

tee /etc/sysctl.d/k8s.conf <<- EOF
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
sysctl --system

systemctl enable docker.service

k8s_ver='1.20.0'
apt-get update
apt-get install -y \
	kubelet="${k8s_ver}-00" \
	kubeadm="${k8s_ver}-00" \
	kubectl="${k8s_ver}-00"