#!/usr/bin/env bash

source ./01-env.sh

etcdctl put "chave1" "value1"
etcdctl put "chave2" "value2"
etcdctl put "chave3" "value3"
