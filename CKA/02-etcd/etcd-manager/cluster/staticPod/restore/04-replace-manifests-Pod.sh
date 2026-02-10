#!/usr/bin/env bash

cp /etc/kubernetes/manifests/etcd.yaml /backup
#
# \1 ( Retrovisor ) => Agrupa o item capturado (--initial-cluster=)
# [^"]* => Pega qualquer coisa apos o = exceto " que tenha mais de 1 ocorrencia
#
sed -i -E 's|(--initial-cluster=)[^"]*|\1master01=https://10.100.100.11:2380,master02=https://10.100.100.12:2380,master03=https://10.100.100.13:2380|' /etc/kubernetes/manifests/etcd.yaml
sed -i -E 's|(--initial-cluster-state=)[^"]*|\1new|' /etc/kubernetes/manifests/etcd.yaml


systemctl start kubelet
