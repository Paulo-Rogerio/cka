# 🚀 Manager Data Etcd

- [1) ETCD StaticPod](#1-etcd-staticpod)
- [1.1) ETCD EndPoints](#11-etcd-endpoints)
- [1.2) ETCD Insert Data](#12-etcd-insert-data)
- [1.3) ETCD Delete Data](#13-etcd-delete-data)

## 1) ETCD StaticPod

Após deployado deployar o **etcd** via staticPod, mantido pelo e gerido pelo **kubernetes** via **StaticPod**, vamos manipular os dados.

Execute os seguinte comando nos **2** nodes **(master01 e master02)**

```bash
crictl ps
CONTAINER           IMAGE               CREATED             STATE               NAME                ATTEMPT             POD ID              POD                 NAMESPACE
d250b560b5792       a3e246e9556e9       3 minutes ago       Running             etcd                0                   e9d254ae8eae8       etcd-master01       kube-system
```

```bash
crictl ps
CONTAINER           IMAGE               CREATED             STATE               NAME                ATTEMPT             POD ID              POD                 NAMESPACE
cf30e0cbbd5f4       a3e246e9556e9       4 minutes ago       Running             etcd                0                   e3c11d14b9a87       etcd-master02       kube-system
```

## 1.1) ETCD EndPoints

```bash
cd /root/kubernetes-certifications/CKA/02-etcd/etcd-manager/data

sh 02-list-members.sh
+------------------+---------+----------+----------------------------+----------------------------+------------+
|        ID        | STATUS  |   NAME   |         PEER ADDRS         |        CLIENT ADDRS        | IS LEARNER |
+------------------+---------+----------+----------------------------+----------------------------+------------+
| 6f9a16d488597713 | started | master01 | https://10.100.100.11:2380 | https://10.100.100.11:2379 |      false |
| 8cd2a87e18f78509 | started | master02 | https://10.100.100.12:2380 | https://10.100.100.12:2379 |      false |
+------------------+---------+----------+----------------------------+----------------------------+------------+


sh 03-endpoint-health.sh
+-----------------------+--------+-------------+-------+
|       ENDPOINT        | HEALTH |    TOOK     | ERROR |
+-----------------------+--------+-------------+-------+
| https://master02:2379 |   true |  6.328564ms |       |
| https://master01:2379 |   true | 29.912501ms |       |
+-----------------------+--------+-------------+-------+
```

Para os scripts acima funcionar é necessário informar os endpoints e os certificados.


```bash
cat > /root/etcdctl.env <<EOF
export ETCDCTL_ENDPOINTS=https://master01:2379,https://master02:2379
export ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt
export ETCDCTL_CERT=/etc/kubernetes/pki/etcd/peer.crt
export ETCDCTL_KEY=/etc/kubernetes/pki/etcd/peer.key
EOF

source /root/etcdctl.env
```

## 1.2) ETCD Insert Data

Os dados podem ser inseridos em qualquer membro do cluster, todos tem papel de leitura e escrita.

No exemplo abaixo , está sendo inserido **10 registros** no membro **master02**.

```bash
sh 05-insert-item.sh
OK
OK
OK
OK
OK
OK
OK
OK
OK
OK
```

```bash
sh 06-read-item.sh
#
# O script se resume na execução dos comandos abaixo
#
etcdctl get chave1 -w simple
etcdctl get chave --prefix -w json | jq .
```

No exemplo abaixo estamos listando os dados no formato **json**.

```json
{
  "header": {
    "cluster_id": 8022778274498925000,
    "member_id": 10147358169957370000,
    "revision": 11,
    "raft_term": 2
  },
  "kvs": [
    {
      "key": "Y2hhdmUx",
      "create_revision": 2,
      "mod_revision": 2,
      "version": 1,
      "value": "dmFsdWUx"
    },
    {
      "key": "Y2hhdmUxMA==",
      "create_revision": 11,
      "mod_revision": 11,
      "version": 1,
      "value": "dmFsdWUxMA=="
    },
    {
      "key": "Y2hhdmUy",
      "create_revision": 3,
      "mod_revision": 3,
      "version": 1,
      "value": "dmFsdWUy"
    },
    {
      "key": "Y2hhdmUz",
      "create_revision": 4,
      "mod_revision": 4,
      "version": 1,
      "value": "dmFsdWUz"
    },
    {
      "key": "Y2hhdmU0",
      "create_revision": 5,
      "mod_revision": 5,
      "version": 1,
      "value": "dmFsdWU0"
    },
    {
      "key": "Y2hhdmU1",
      "create_revision": 6,
      "mod_revision": 6,
      "version": 1,
      "value": "dmFsdWU1"
    },
    {
      "key": "Y2hhdmU2",
      "create_revision": 7,
      "mod_revision": 7,
      "version": 1,
      "value": "dmFsdWU2"
    },
    {
      "key": "Y2hhdmU3",
      "create_revision": 8,
      "mod_revision": 8,
      "version": 1,
      "value": "dmFsdWU3"
    },
    {
      "key": "Y2hhdmU4",
      "create_revision": 9,
      "mod_revision": 9,
      "version": 1,
      "value": "dmFsdWU4"
    },
    {
      "key": "Y2hhdmU5",
      "create_revision": 10,
      "mod_revision": 10,
      "version": 1,
      "value": "dmFsdWU5"
    }
  ],
  "count": 10
}
```

## 1.3) ETCD Delete Data


```bash
sh 07-delete-item.sh
1
1
#
# A execução do script removerá 2 registros
#
etcdctl del chave10
etcdctl del chave9
```

Ao executar o contador novamente, podemos ver apenas 8 registros.

```json
  ...
  ...
  ],
  "count": 8
}
```
