# 🚀 Learn Etcd

- [1) Vms Requisitos](#1-vms-requisitos)
- [2) Vms Startup](#2-vms-startup)
- [3) Deploy Kubernetes Single Master](#3-deploy-kubernetes-single-master)
- [4) Informações Sobre Cluster](#4-informações-sobre-cluster)


## 1) Vms Requisitos

Para execução desse laboratório é necessário ter o **KVM** instalado no host, pois ele irá emular todos as vms necessárias.

#### Imagens Cloud

É necessário baixar a imagem no formato **qcow2** que já vem adaptada para rodar com cloud-init. [Download Oficial](https://cloud-images.ubuntu.com/).

#### Diretório das Imagens

Esse script assumi que as imagens devam estar localizadas em **/var/lib/libvirt/images/**.

#### Chave SSH

É necessário ter um par de chaves SSH do tipo **id_ed25519** (privada e pública) moderno e seguro, baseado no algoritmo Ed25519 para autenticação sem senha nos servidores.

```bash
ssh-keygen -t ed25519 -C "seu_email@exemplo.com"
```

#### Adicionar Entradas no seu /etc/hosts

Isso irá ajudar muito na conexão SSH

```bash
# Estudos Cka
#==============================
10.100.100.10       vip
10.100.100.11       master01
10.100.100.12       master02
10.100.100.13       master03
10.100.100.20       worker01
```

#### Password Default todas as Vms

Todas as vms tem uma senha default já definida no cloud-init **123456**.

## 2) Vms Startup

[Clone o Repositório](https://github.com/Paulo-Rogerio/kubernetes-certifications.git), e navegue no diretório **01-kvm**. Nesse diretório, você irá encontrar um arquivo **hosts.txt**, ele é quem irá definir a quantidade de hosts que terá seu laboratório.

```bash
#===========================================================================
# Estudos K8S
#===========================================================================
# Vm Name  |  Ram  | vCPU  |     Ip        |   Imagem Cloud Init
#===========================================================================
master01      2048    3       10.100.100.11    jammy-server-cloudimg-amd64.img
worker01      2048    3       10.100.100.20    jammy-server-cloudimg-amd64.img
#===========================================================================
# Estudos ETCD
#===========================================================================
# master01   2048     3      10.100.100.11    jammy-server-cloudimg-amd64.img
# master02   2048     3      10.100.100.12    jammy-server-cloudimg-amd64.img
# master03   2048     3      10.100.100.13    jammy-server-cloudimg-amd64.img
```

O instalador já garante que essa network será criada, então **NÂO** altere o range **10.100.100.**. Essa rede é criada no modo **NAT**, para evitar qualquer tipo de conflito.

#### Iniciando Vms

Esse utilitário já cria todo os requisitos necessários.

```bash
sh deploy.sh
```

Conecte-se na Vm recém criada.

```bash
ssh root@master01
```

#### Removendo Vms

Remova as Vms após o término do laboratório.

```bash
sh remove.sh
```

## 3) Deploy Kubernetes Single Master

Após deployado as Vms conecte-se em (**master01 e worker01**).

Isso irá deployar o **etcd** externo , mantido pelo S.O e gerido pelo **systemd**.

Será perguntando como o **etcd** irá rodar, na ocasião estou rodando com etcd **interno**. Tem um material falando apenas de **ETCD**, consulte o [Menu](https://github.com/Paulo-Rogerio/kubernetes-certifications/blob/main/README.md).

```bash
ssh root@master01
cd /root/kubernetes-certifications/CKA/03-k8s/singeMaster
bash deploy-master.sh

Como o Kubernetes ira usar o etcd? (1) ETCD interno. (2) ETCD external : 1
Usando ETCD: Interno

kubectl get nodes

NAME       STATUS   ROLES           AGE     VERSION
master01   Ready    control-plane   5m37s   v1.34.4
```

Após deployado o **master01** ,conecte-se na **worker01** e execute procedimento semelhante.

```bash
ssh root@worker01
cd /root/kubernetes-certifications/CKA/03-k8s/singeMaster
bash deploy-worker.sh
kubectl get nodes

NAME       STATUS   ROLES           AGE     VERSION
master01   Ready    control-plane   14m     v1.34.4
worker01   Ready    <none>          6m41s   v1.34.4
```

## 4) Informações Sobre Cluster

### Versão do Cliente Kubernetes instalado

```bash
kubeadm version -o short
```

### Manifesto YAML padrão usado pelo Kubeadm init

```bash
kubeadm config print init-defaults
```

### Gerar Token
```bash
echo "$(kubeadm token create --print-join-command)" > join.sh

kubeadm join 10.100.100.10:6443 \
  --token yw814a.mk47hgqt1yayq26k \
  --discovery-token-ca-cert-hash sha256:7613f7a62eb387ebc300bdd56bcf35782cbf0fea5bc7e622d58bb2b364b08730
```
