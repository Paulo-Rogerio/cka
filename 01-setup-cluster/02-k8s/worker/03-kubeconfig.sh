#!/usr/bin/env bash

echo "***********************************************************************"
echo "* Copy Kubeconfig                                                     *"
echo "***********************************************************************"
echo

mkdir -p /home/vagrant/.kube
mkdir -p /root/.kube
scp root@master01:/root/.kube/config /root/.kube/
