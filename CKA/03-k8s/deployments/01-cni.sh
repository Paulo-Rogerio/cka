#!/usr/bin/env bash

kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

function check_pod_running(){
    deployment=$1
    namespace=$2
    todo=true

    [[ -z ${deployment} || -z ${namespace} ]] && echo "Namespace e Deployment não informados" && exit 1

    while ${todo};
    do
      kubectl rollout status daemonset/${deployment} -n ${namespace} &> /dev/null
      [[ $? == 0 ]] && export todo=false
      echo "Waiting Pod Health..."
      sleep 10
    done
    echo "Pods Running"
}

# Check
check_pod_running kube-flannel-ds kube-flannel
