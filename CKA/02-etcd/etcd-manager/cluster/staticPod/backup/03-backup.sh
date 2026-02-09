#!/usr/bin/env bash

source ./01-env.sh
source /root/etcdctl.env

mkdir -p /backup
etcdctl snapshot save /backup/etcd-$(date +%F-%H%M).db
