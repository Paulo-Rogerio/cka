#!/usr/bin/env bash

# Assumindo que estou restaurando a partir do master03
#
etcdctl snapshot restore /backup/etcd-2026-02-10-0505.db \
  --data-dir=/var/lib/etcd \
  --name=master03 \
  --initial-cluster=master01=https://10.100.100.11:2380,master02=https://10.100.100.12:2380,master03=https://10.100.100.13:2380 \
  --initial-cluster-state=new \
  --initial-advertise-peer-urls=https://10.100.100.13:2380
