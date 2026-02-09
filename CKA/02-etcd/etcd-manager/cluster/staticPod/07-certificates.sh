#!/usr/bin/env bash


HOSTS=("master03")

for i in ${HOSTS[@]}
do
  kubeadm init phase certs etcd-server --config=/root/kubeadmcfg-etcd/${i}/kubeadmcfg.yaml
  kubeadm init phase certs etcd-peer --config=/root/kubeadmcfg-etcd/${i}/kubeadmcfg.yaml
  kubeadm init phase certs etcd-healthcheck-client --config=/root/kubeadmcfg-etcd/${i}/kubeadmcfg.yaml
  kubeadm init phase certs apiserver-etcd-client --config=/root/kubeadmcfg-etcd/${i}/kubeadmcfg.yaml
  mkdir -p /root/kubeadmcfg-etcd/${i}/certs
  cp -R /etc/kubernetes/pki /root/kubeadmcfg-etcd/${i}/certs
  scp -r root@master01:/etc/kubernetes/pki/etcd/ca.crt /root/kubeadmcfg-etcd/${i}/certs
  scp -r root@master01:/etc/kubernetes/pki/etcd/ca.key /root/kubeadmcfg-etcd/${i}/certs
  find /etc/kubernetes/pki -type f -delete
done
