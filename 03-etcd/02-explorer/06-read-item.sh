#!/usr/bin/env bash

source /root/etcdctl.env

echo "---------"
etcdctl get chave1 --prefix --write-out=table

echo "---------"
etcdctl get chave2 --prefix --write-out=table

echo "---------"
etcdctl get chave3 --prefix --write-out=table
echo "---------"
