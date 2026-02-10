#!/usr/bin/env bash

# executar no no zuado

cat > /root/etcdctl.env <<EOF
export ETCDCTL_ENDPOINTS=https://master03:2379
export ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt
export ETCDCTL_CERT=/etc/kubernetes/pki/etcd/healthcheck-client.crt
export ETCDCTL_KEY=/etc/kubernetes/pki/etcd/healthcheck-client.key
EOF

source /root/etcdctl.env

etcdctl member update 8e9e05c52164694d \
  --peer-urls=https://10.100.100.13:2380
