#!/usr/bin/env bash

tee -a /etc/bash.bashrc <<-'EOF'
alias sync='rsync -av --progress --delete /vagrant/ ~/box'
EOF