#!/usr/bin/env bash

cd $(dirname $0)

source ./01-upgrade.sh
source ./02-common.sh
source ./03-etcdctl.sh
source ./04-kubeadmcfg.sh
source ./05-kubelet.sh

if [[ $(hostname -s) == "master01" ]]
then
  source ./06-ca.sh
  source ./07-certificates.sh
  source ./08-start.sh
  sleep 20
  crictl ps

else
  source ./08-start.sh
  sleep 20
  crictl ps

fi
