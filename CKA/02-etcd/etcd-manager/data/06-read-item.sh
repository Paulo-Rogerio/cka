#!/usr/bin/env bash
source ./01-env.sh

for i in {1..10}
do
  etcdctl get chave{i} --prefix -w simple
  echo "---------"
done

echo "################## JQ ####################"

for i in {1..10}
do
  etcdctl get chave{i} --prefix -w json | jq .
  echo "---------"
done
