#!/usr/bin/env bash

source /root/etcdctl.env

etcdctl member add etcd4 --peer-urls=https://etcd4:2380
