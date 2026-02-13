# 🚀 Learn Kubernetes

## Versão do Cliente Kubernetes instalado

```bash
kubeadm version -o short
```

## Manifesto YAML padrão usado pelo Kubeadm init

```bash
kubeadm config print init-defaults
```

## Gerar String para inserir um membro ao cluster

```bash
echo "$(kubeadm token create --print-join-command)" > join.sh

cat join.sh

kubeadm join 10.100.100.10:6443 \
  --token yw814a.mk47hgqt1yayq26k \
  --discovery-token-ca-cert-hash sha256:7613f7a62eb387ebc300bdd56bcf35782cbf0fea5bc7e622d58bb2b364b08730
```
