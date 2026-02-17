#!/usr/bin/env bash

cat > /root/etcdctl.env <<EOF
export ETCDCTL_ENDPOINTS=https://master01:2379,https://master02:2379,https://master03:2379
export ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt
export ETCDCTL_CERT=/etc/kubernetes/pki/etcd/peer.crt
export ETCDCTL_KEY=/etc/kubernetes/pki/etcd/peer.key
EOF

source /root/etcdctl.env

etcdctl member add master03 --peer-urls=https://10.100.100.13:2380
