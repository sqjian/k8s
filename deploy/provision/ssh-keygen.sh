#!/usr/bin/env bash

ssh-keygen

ssh-copy-id -i ~/.ssh/id_rsa.pub root@x.x.x.x