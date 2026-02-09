# Deploy ETCD Systemd

Para esse laboratório é esperado que o **ETCD** rode fora do cluster.

```bash
02-etcd/etcd-systemd/deploy-master01.sh
02-etcd/etcd-systemd/deploy-master02.sh
```

# Deploy Kubernetes Single Control Plane

```bash
02-k8s/singleNode/deploy-master.sh
02-k8s/singleNode/deploy-worker.sh
```

# Gerar Token
```bash
echo "$(kubeadm token create --print-join-command)" > ${JOIN_FILE}/join.sh

kubeadm join 10.100.100.10:6443 \
  --token yw814a.mk47hgqt1yayq26k \
  --discovery-token-ca-cert-hash sha256:7613f7a62eb387ebc300bdd56bcf35782cbf0fea5bc7e622d58bb2b364b08730
```
