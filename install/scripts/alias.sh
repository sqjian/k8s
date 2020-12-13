#!/usr/bin/env bash

set -eux

tee -a /etc/bash.bashrc <<-'EOF'
alias sync='rsync -av --progress --delete /vagrant ~/vagrant'
EOF
