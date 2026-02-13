# 🚀 Learn Etcd

- [1) Vms Requisitos](#1-vms-requisitos)
- [2) Vms Startup](#2-vms-startup)
- [3) ETCD SystemD](#3-etcd-systemd)
- [4) ETCD StaticPod](#4-etcd-staticpod)


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
# master01   2048     3      10.100.100.11   jammy-server-cloudimg-amd64.img
# master02   2048     3      10.100.100.12   jammy-server-cloudimg-amd64.img
# worker01   2048     3      10.100.100.20   jammy-server-cloudimg-amd64.img
#===========================================================================
# Estudos ETCD
#===========================================================================
master01     2048     3      10.100.100.11    jammy-server-cloudimg-amd64.img
master02     2048     3      10.100.100.12    jammy-server-cloudimg-amd64.img
master03     2048     3      10.100.100.13    jammy-server-cloudimg-amd64.img
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

## 3) ETCD SystemD

Para fins didáticos temos 2 opções para rodar o **etcd**: Como serviço **SystemD**, ou como **Static Pod**. Para entender como funciona o serviço foi criado essas 2 implementações.

Após deployado as Vms conecte-se em (**master01 e master02**).

Isso irá deployar o **etcd** externo , mantido pelo S.O e gerido pelo **systemd**.

```bash
ssh root@master01
cd kubernetes-certifications/CKA/02-etcd/etcd-systemd/
bash deploy-master01.sh
systemctl status etcd
```

Conecte-se na master02 e execute procedimento semelhante

```bash
ssh root@master02
cd kubernetes-certifications/CKA/02-etcd/etcd-systemd/
bash deploy-master02.sh
systemctl status etcd
```

#### OBS.: Subimos 3 Vms , mas o etcd foi instalado em apenas 2 membros. Isso foi proposital, para aprendermos manipular o ETCD.

A manipulação dos dados no ETCD pode acontecer em qualquer node.

Os scripts para manipulação dos **dados** ficam em: */root/kubernetes-certifications/CKA/02-etcd/etcd-manager/data*

```bash
cd /root/kubernetes-certifications/CKA/02-etcd/etcd-manager/data
bash 02-list-members.sh

+------------------+---------+----------+-----------------------+----------------------------+------------+
|        ID        | STATUS  |   NAME   |      PEER ADDRS       |        CLIENT ADDRS        | IS LEARNER |
+------------------+---------+----------+-----------------------+----------------------------+------------+
| 3713bd59c3918478 | started | master01 | https://master01:2380 | https://10.100.100.11:2379 |      false |
| 43450b1d21f3b96a | started | master02 | https://master02:2380 | https://10.100.100.12:2379 |      false |
+------------------+---------+----------+-----------------------+----------------------------+------------+
```

Os scripts para manipulação do **cluster** ficam em: */root/kubernetes-certifications/CKA/02-etcd/etcd-manager/cluster/systemd*

Essa implementação baseada em **SystemD** é apenas para clarificar como se comporta o serviço. Não vou detalhar procedimentos aqui, visto que para **CKA** a implementação cobrada e baseada em **POD**

## 4) ETCD StaticPod


Após deployado as Vms conecte-se em (**master01 e master02**). Para esse laboratório vamos deployar o **etcd** interno, mantido pelo e gerido pelo **kubernetes** via **StaticPod**.


Conecte-se na master01...

```bash
ssh root@master01
cd kubernetes-certifications/CKA/02-etcd/etcd-staticPod/
bash deploy.sh
crictl ps -a | grep etcd
crictl logs 992e3500eddf6
systemctl status kubelet
```

#### OBS.: O mesmo script atende ambas implementações

Conecte-se na master02 e execute procedimento semelhante

```bash
ssh root@master02
cd kubernetes-certifications/CKA/02-etcd/etcd-staticPod/
bash deploy.sh
crictl ps -a | grep etcd
crictl logs 992e3500eddf6
systemctl status kubelet
```
