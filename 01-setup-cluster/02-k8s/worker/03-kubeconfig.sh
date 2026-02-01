#!/usr/bin/env bash

echo "***********************************************************************"
echo "* Copy Kubeconfig                                                     *"
echo "***********************************************************************"
echo

mkdir -p /home/vagrant/.kube
mkdir -p /root/.kube
cp -i /etc/kubernetes/admin.conf /root/.kube/config