## ※ 系统环境

| 系统         | 内核             | docker  | ip            | 主机名 | 配置  |
| ------------ | ---------------- | ------- | ------------- | ------ | ----- |
| ubuntu 20.04 | 5.4.0-56-generic | 19.03.8 | 192.168.60.11 | master | 4核8G |
| ubuntu 20.04 | 5.4.0-56-generic | 19.03.8 | 192.168.60.21 | slave1 | 4核8G |
| ubuntu 20.04 | 5.4.0-56-generic | 19.03.8 | 192.168.60.22 | slave2 | 4核8G |



## ※ Master

```bash
#!/usr/bin/env bash

set -eux

swapoff -a

tee /etc/sysctl.d/k8s.conf <<- EOF
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
sysctl --system

apt-get update && apt-get install -y apt-transport-https
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
tee /etc/apt/sources.list.d/kubernetes.list <<- EOF
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF

k8s_ver='1.20.0'
apt-get update
apt-get install -y \
	kubelet="${k8s_ver}-00" \
	kubeadm="${k8s_ver}-00" \
	kubectl="${k8s_ver}-00"

kubeadm config images pull \
--image-repository registry.aliyuncs.com/google_containers \
--kubernetes-version v${k8s_ver} \
--v=5

kubeadm init \
--apiserver-advertise-address=192.168.60.11 \
--image-repository registry.aliyuncs.com/google_containers \
--kubernetes-version v${k8s_ver} \
--service-cidr=10.1.0.0/16 \
--pod-network-cidr=10.244.0.0/16 \
--ignore-preflight-errors=all \
--v=5

# 解除 master 节点默认不能运行 pod
kubectl taint nodes --all node-role.kubernetes.io/master-
# 恢复默认值
# $ kubectl taint nodes NODE_NAME node-role.kubernetes.io/master=true:NoSchedule


# cni
# https://raw.githubusercontent.com/coreos/flannel/v0.13.0/Documentation/kube-flannel.yml
# grep image yaml/kube-flannel.yml |uniq
aliyuncs_image=registry.cn-hangzhou.aliyuncs.com/google_imags_kubernetes/flannel:v0.13.0
docker pull ${aliyuncs_image}
docker tag ${aliyuncs_image} quay.io/coreos/flannel:v0.13.0

kubectl delete -f yaml/kube-flannel.yml
kubectl apply -f yaml/kube-flannel.yml
```



## ※ Slave

```bash
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


# cni
# https://raw.githubusercontent.com/coreos/flannel/v0.13.0/Documentation/kube-flannel.yml
# grep image yaml/kube-flannel.yml |uniq
aliyuncs_image=registry.cn-hangzhou.aliyuncs.com/google_imags_kubernetes/flannel:v0.13.0
docker pull ${aliyuncs_image}
docker tag ${aliyuncs_image} quay.io/coreos/flannel:v0.13.0
```

