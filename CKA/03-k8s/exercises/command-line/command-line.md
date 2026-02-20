
# 🚀 Command Line - Contexts

```bash
k config get-contexts
k config set-context <name-context> --namespace='<namespace>'
k config set-context kubernetes-admin@kubernetes --namespace='metallb-system'
k config set-context kubernetes-admin@kubernetes --namespace=''

# Aplica-se ao contexto current
k config set-context --current --namespace=default

# Merge 2 kubeconfig
kubectl config view --flatten

KUBECONFIG=~/.kube/config:~/.kube/kube_outro_cluster_config kubectl config view --flatten > ~/.kube/kube-merge

# AWS ( EKS )
aws eks update-kubeconfig --dry-run --name paulo --region us-east-2
```

# 🚀 Command Line - Nodes

```bash
k get nodes

# Ip Node
k get nodes -o wide

# Manifestos do Node
k get nodes -o yaml

# Precisa-se no Metric Server.
# O fato de ter o MetalLB deployado permite export ExternalIP
k top nodes

helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm repo update
helm upgrade \
  --install \
  --namespace kube-system \
  --create-namespace metrics-server metrics-server/metrics-server \
  --set-string args[0]=--kubelet-insecure-tls \
  --set-string args[1]="--kubelet-preferred-address-types=InternalIP\,Hostname\,ExternalIP"

# Definir Label ( Rótulo )
nodes=$(kubectl get nodes --no-headers | awk '$3 == "<none>" {print $1}')
for i in ${nodes[@]}
do
  kubectl label node ${i} node-role.kubernetes.io/worker=""
done

# Não schedular nenhum pod no worker
kubectl cordon worker01
kubectl uncordon worker01
```

# 🚀 Command Line - Pods

```bash
# Nivel de verbosidade + alto
k get pods -A -v9

# Consulmindo a API
kubectl config view --raw -o jsonpath='{.users[0].user.client-certificate-data}' | base64 -d > /tmp/cert.crt
kubectl config view --raw -o jsonpath='{.users[0].user.client-key-data}' | base64 -d > /tmp/cert.key
curl \
  -k \
  --cert /tmp/cert.crt \
  --key /tmp/cert.key \
  --cacert /etc/kubernetes/pki/ca.crt \
  https://127.0.0.1:6443/api/v1/pods?limit=500

openssl x509 -in /tmp/cert.crt -text

# Consultando Usando Rotas anonimas
curl -k https://127.0.0.1:6443/version
curl -k https://127.0.0.1:6443/healthz
curl -k https://127.0.0.1:6443/livez
curl -k https://127.0.0.1:6443/readyz

# Check Cluster aceita rotas anonimas
cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep anonymous

# List Pods
k get pod

# Lista todos Namespaces
k get pod -A

k get pod -A --show-labels
k get pod -n kube-system etcd-master01
k get pod -A -l <label>=<value>
k get pod -A -l component=etcd

# Ip Pods.
k get pod -A -o wide

# "Assistindo" mudanças em tempo real.
k get pod -A -w

k edit pod -n kube-system etcd-master01
k describe pod -n kube-system etcd-master01
k delete pod -n kube-system etcd-master01

k logs pod -n <namespace> <pod>
k logs pod -n kube-system etcd-master01

# Conectar no container
k exec -it -n <namespace> <pod> -- bash
k exec -it -n kube-flannel kube-flannel-ds-77m55 -- bash
k exec -it -n kube-flannel kube-flannel-ds-77m55 -- bash -c "pwd; ls"
```
