#!/usr/bin/env bash

mkdir -p /root/kubeadmcfg-etcd
scp -r root@master01:/root/kubeadmcfg-etcd/master01 /root/kubeadmcfg-etcd
