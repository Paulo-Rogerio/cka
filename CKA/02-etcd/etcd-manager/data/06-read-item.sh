#!/usr/bin/env bash
source ./01-env.sh

for i in {1..10}
do
  etcdctl get chave{i} --prefix -w simple
  etcdctl get chave{i} --prefix -w json | jq .
  echo "---------"
done
