#!/usr/bin/env bash

function check_pod_running(){
    deployment=$1
    namespace=$2
    todo=true

    [[ -z ${deployment} || -z ${namespace} ]] && echo "Namespace e Deployment não informados" && exit 1

    while ${todo};
    do
      kubectl rollout status deployment/${deployment} -n ${namespace} &> /dev/null
      [[ $? == 0 ]] && export todo=false
      echo "Waiting Pod Health..."
      sleep 10
    done
    echo "Pods Running"
}

echo "***********************************************************************"
echo "* Install Metric-Server                                               *"
echo "***********************************************************************"
echo
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm repo update
helm upgrade \
  --install \
  --namespace kube-system \
  --create-namespace metrics-server metrics-server/metrics-server \
  --set-string args[0]=--kubelet-insecure-tls \
  --set-string args[1]="--kubelet-preferred-address-types=InternalIP\,Hostname\,ExternalIP"

# Check
check_pod_running metrics-server kube-system
