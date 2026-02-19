#!/usr/bin/env bash

cd $(dirname $0)


if [[ $(hostname -s) == "master01" ]]
then
  source ./01-common.sh
  source ./02-vip.sh
  source ./03-init.sh
  source ../deployments/01-cni.sh
  source ../deployments/02-taint.sh
  source ../deployments/03-metallb.sh
  source ../deployments/04-metrics-server.sh
else
  source ./01-common.sh
  source ./03-init.sh
  source ../deployments/01-cni.sh
  source ../deployments/05-label.sh
fi

bash
