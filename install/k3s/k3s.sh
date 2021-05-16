#!/usr/bin/env bash

set -eux

# master
curl -sfL http://rancher-mirror.cnrancher.com/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -s - --docker --disable=traefik