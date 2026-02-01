#!/usr/bin/env bash

source /root/etcdctl.env

echo "---------"
etcdctl --endpoints=https://localhost:2379 get chave1 --prefix

echo "---------"
etcdctl --endpoints=https://localhost:2379 get chave2 --prefix

echo "---------"
etcdctl --endpoints=https://localhost:2379 get chave3 --prefix
echo "---------"
