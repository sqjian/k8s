# 1、安装

## ※ 系统环境

| 系统         | 内核             | docker  | ip            | 主机名 | 配置  |
| ------------ | ---------------- | ------- | ------------- | ------ | ----- |
| ubuntu 20.04 | 5.4.0-56-generic | 19.03.8 | 192.168.60.11 | master | 4核8G |
| ubuntu 20.04 | 5.4.0-56-generic | 19.03.8 | 192.168.60.21 | slave1 | 4核8G |
| ubuntu 20.04 | 5.4.0-56-generic | 19.03.8 | 192.168.60.22 | slave2 | 4核8G |



## ※ Master

```
#!/usr/bin/env bash

set -eux

./k8s-master.sh
./taint.sh
./cni.sh
./dashboard.sh
./admin-user.sh
```



## ※ Slave

```bash
#!/usr/bin/env bash

set -eux

./k8s-slave.sh
```

# 2、FAQ

## 2.1、NodePort 修改

### ※ 修改kube-apiserver.yaml ###

```text
使用 kubeadm 安装 K8S 集群的情况下，Master 节点上会有一个文件 /etc/kubernetes/manifests/kube-apiserver.yaml，修改此文件，向其中添加 --service-node-port-range=1-65535 （需要的端口范围）
```

### ※ 重启apiserver ###

```bash
# 获得 apiserver 的 pod 名字
export apiserver_pods=$(kubectl get pods --selector=component=kube-apiserver -n kube-system --output=jsonpath={.items..metadata.name})
# 删除 apiserver 的 pod
kubectl delete pod $apiserver_pods -n kube-system
```

### ※ 验证结果 ###

```bash
kubectl describe pod $apiserver_pods -n kube-system
```
