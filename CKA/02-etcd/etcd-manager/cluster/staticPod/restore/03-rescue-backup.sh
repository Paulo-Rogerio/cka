#!/usr/bin/env bash

# Assumindo que estou restaurando a partir do master03
#
etcdutl snapshot restore /backup/etcd-2026-02-10-0505.db \
  --data-dir=/var/lib/etcd

# Ajustar os manifests dos outros nós (initial-cluster-state=new)

# Subir kubelet:

# systemctl start kubelet
