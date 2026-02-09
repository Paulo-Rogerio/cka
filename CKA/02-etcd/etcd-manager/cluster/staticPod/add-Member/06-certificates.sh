#!/usr/bin/env bash


HOSTS=("master03")

mkdir -p /etc/kubernetes/pki/etcd/
scp -r root@master01:/etc/kubernetes/pki/etcd/ca.crt /etc/kubernetes/pki/etcd/ca.crt
scp -r root@master01:/etc/kubernetes/pki/etcd/ca.key /etc/kubernetes/pki/etcd/ca.key

for i in ${HOSTS[@]}
do
  mkdir -p /root/kubeadmcfg-etcd/${i}
  kubeadm init phase certs etcd-server --config=/root/kubeadmcfg-etcd/${i}/kubeadmcfg.yaml
  kubeadm init phase certs etcd-peer --config=/root/kubeadmcfg-etcd/${i}/kubeadmcfg.yaml
  kubeadm init phase certs etcd-healthcheck-client --config=/root/kubeadmcfg-etcd/${i}/kubeadmcfg.yaml
  kubeadm init phase certs apiserver-etcd-client --config=/root/kubeadmcfg-etcd/${i}/kubeadmcfg.yaml
done
