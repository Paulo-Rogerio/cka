#!/usr/bin/env bash

NAME=$(hostname -s)

kubeadm init phase etcd local --config=/root/kubeadmcfg-etcd/${NAME}/kubeadmcfg.yaml
