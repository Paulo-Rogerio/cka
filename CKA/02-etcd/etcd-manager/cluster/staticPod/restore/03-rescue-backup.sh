#!/usr/bin/env bash

# Assumindo que estou restaurando a partir do master03
#
etcdutl snapshot restore /backup/etcd.db \
  --data-dir=/var/lib/etcd
