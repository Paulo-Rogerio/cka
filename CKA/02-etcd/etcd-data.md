# 🚀 Manager Data Etcd

- [1) ETCD StaticPod](#1-etcd-staticpod)
- [1.1) ETCD EndPoints](#11-etcd-endpoints)
- [1.2) ETCD Data](#1.2-etcd-data)

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
