#!/usr/bin/env bash

sudo mkdir -p ~/.pip
sudo tee ~/.pip/pip.conf <<-'EOF'
[global]
index-url = https://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
EOF
