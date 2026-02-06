#!/usr/bin/env bash

set -eo pipefail

export IP_CONTROL_PLANE="10.100.100.10"
export NODENAME=$(hostname -s)

export TOKEN=$(kubeadm token create)
export HASH=$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt \
              | openssl rsa -pubin -outform der 2>/dev/null \
              | openssl dgst -sha256 -hex \
              | sed 's/^.* //')

export CERT_KEY=$(kubeadm init phase upload-certs --upload-certs 2>/dev/null | tail -n1)


echo "======================================================"
echo " Pull Images "
echo "======================================================"
echo
kubeadm config images pull

echo "======================================================"
echo " Deploy Cluster "
echo "======================================================"
echo

cat > kubeadm-join-master.yaml <<EOF
apiVersion: kubeadm.k8s.io/v1beta4
kind: JoinConfiguration

discovery:
  bootstrapToken:
    apiServerEndpoint: "${IP_CONTROL_PLANE}:6443"
    token: "${TOKEN}"
    caCertHashes:
      - "sha256:${HASH}"

controlPlane:
  certificateKey: "${CERT_KEY}"

nodeRegistration:
  name: ${NODENAME}
EOF

# kubeadm init --config kubeadm-config.yaml --upload-certs
# mkdir -p /root/.kube
# cp -i /etc/kubernetes/admin.conf /root/.kube/config
