#!/usr/bin/env bash

NAME=$(hostname -s)
IP=$(ip -4 addr show enp1s0 | awk '/inet /{print $2}' | cut -d/ -f1 | head -1)

mkdir -p /root/kubeadmcfg-etcd/${NAME}


cat << EOF > /root/kubeadmcfg-etcd/${NAME}/kubeadmcfg.yaml
---
apiVersion: "kubeadm.k8s.io/v1"
kind: InitConfiguration
nodeRegistration:
 name: ${NAME}
localAPIEndpoint:
 advertiseAddress: ${IP}
---
apiVersion: "kubeadm.k8s.io/v1"
kind: ClusterConfiguration
etcd:
 local:
     serverCertSANs:
     - "${IP}"
     peerCertSANs:
     - "${IP}"
     extraArgs:
         initial-cluster: master01=https://10.100.100.11:2380,master02=https://10.100.100.12:2380
         initial-cluster-state: new
         name: ${NAME}
         listen-peer-urls: https://${IP}:2380
         listen-client-urls: https://${IP}:2379
         advertise-client-urls: https://${IP}:2379
         initial-advertise-peer-urls: https://${IP}:2380
EOF
