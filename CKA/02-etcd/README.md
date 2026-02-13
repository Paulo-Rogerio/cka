# 🚀 Learn Etcd

- [1) Vms Requisitos](#1-vms-requisitos)
- [2) Vms Startup](#2-vms-startup)
- [3) ETCD SystemD](#3-etcd-systemd)


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

```bash
ssh root@master01
```

#### Removendo Vms

```bash
sh remove.sh
```

## 3) ETCD SystemD

Examinar saida de logs

```bash
crictl ps -a | grep etcd
crictl logs 992e3500eddf6
systemctl status kubelet
```
