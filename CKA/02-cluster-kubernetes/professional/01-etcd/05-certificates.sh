#!/usr/bin/env bash


NAME=$(hostname -s)

kubeadm init phase certs etcd-server --config=/root/kubeadmcfg-etcd/${NAME}/kubeadmcfg.yaml
kubeadm init phase certs etcd-peer --config=/root/kubeadmcfg-etcd/${NAME}/kubeadmcfg.yaml
kubeadm init phase certs etcd-healthcheck-client --config=/root/kubeadmcfg-etcd/${NAME}/kubeadmcfg.yaml
kubeadm init phase certs apiserver-etcd-client --config=/root/kubeadmcfg-etcd/${NAME}/kubeadmcfg.yaml
