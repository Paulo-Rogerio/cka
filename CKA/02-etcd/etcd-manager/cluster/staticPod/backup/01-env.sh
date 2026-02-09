#!/usr/bin/env bash

cat > /root/etcdctl.env <<EOF
export ETCDCTL_ENDPOINTS=https://master01:2379,https://master03:2379
export ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt
export ETCDCTL_CERT=/etc/kubernetes/pki/etcd/healthcheck-client.crt
export ETCDCTL_KEY=/etc/kubernetes/pki/etcd/healthcheck-client.key
EOF
