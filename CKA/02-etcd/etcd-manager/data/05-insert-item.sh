#!/usr/bin/env bash

source ./01-env.sh

for i in {1..10}
do
  etcdctl put "chave${i}" "value{i}"
  etcdctl put "chave${i}" "value{i}"
  etcdctl put "chave${i}" "value{i}"
done
