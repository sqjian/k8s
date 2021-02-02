#!/usr/bin/env bash

set -eux

kubectl label node slave node-role.kubernetes.io/worker=worker
