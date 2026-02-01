#!/usr/bin/env bash

source /root/etcdctl.env

etcdctl --endpoints=https://localhost:2379 put "chave1" "value1"
etcdctl --endpoints=https://localhost:2379 put "chave2" "value2"
etcdctl --endpoints=https://localhost:2379 put "chave3" "value3"
