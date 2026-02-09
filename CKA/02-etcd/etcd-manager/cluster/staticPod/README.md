# Debug ETCD Kubelet

Examinar saida de logs

```bash
crictl ps -a | grep etcd
crictl logs 992e3500eddf6
systemctl status kubelet
```

# Query

Aqui defini apenas um único endpoint **master01** para consulta.

```bash
cat > /root/etcdctl.env <<EOF
export ETCDCTL_ENDPOINTS=https://master01:2379
export ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt
export ETCDCTL_CERT=/etc/kubernetes/pki/etcd/peer.crt
export ETCDCTL_KEY=/etc/kubernetes/pki/etcd/peer.key
EOF

source /root/etcdctl.env
etcdctl member list --write-out=table
```

```bash
+------------------+---------+----------+----------------------------+----------------------------+------------+
|        ID        | STATUS  |   NAME   |         PEER ADDRS         |        CLIENT ADDRS        | IS LEARNER |
+------------------+---------+----------+----------------------------+----------------------------+------------+
| 6f9a16d488597713 | started | master01 | https://10.100.100.11:2380 | https://10.100.100.11:2379 |      false |
| 8cd2a87e18f78509 | started | master02 | https://10.100.100.12:2380 | https://10.100.100.12:2379 |      false |
| dea3c1946426d2a3 | started | master03 | https://10.100.100.13:2380 | https://10.100.100.13:2379 |      false |
+------------------+---------+----------+----------------------------+----------------------------+------------
```

## Endpoint Health

```bash
cat > /root/etcdctl.env <<EOF
export ETCDCTL_ENDPOINTS=https://master01:2379,https://master02:2379,https://master03:2379
export ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt
export ETCDCTL_CERT=/etc/kubernetes/pki/etcd/peer.crt
export ETCDCTL_KEY=/etc/kubernetes/pki/etcd/peer.key
EOF

source /root/etcdctl.env
etcdctl endpoint health --write-out=table
```

```bash
+-----------------------+--------+-------------+-------+
|       ENDPOINT        | HEALTH |    TOOK     | ERROR |
+-----------------------+--------+-------------+-------+
| https://master01:2379 |   true | 21.661773ms |       |
| https://master02:2379 |   true | 47.537257ms |       |
| https://master03:2379 |   true | 47.352907ms |       |
+-----------------------+--------+-------------+-------+
```

## Reomvendo um membro

```bash
sh 03-remove-member.sh 8cd2a87e18f78509
Member 8cd2a87e18f78509 removed from cluster 6f56a2558b3ad1a1

sh 02-list-members.sh
+------------------+---------+----------+----------------------------+----------------------------+------------+
|        ID        | STATUS  |   NAME   |         PEER ADDRS         |        CLIENT ADDRS        | IS LEARNER |
+------------------+---------+----------+----------------------------+----------------------------+------------+
| 6f9a16d488597713 | started | master01 | https://10.100.100.11:2380 | https://10.100.100.11:2379 |      false |
| dea3c1946426d2a3 | started | master03 | https://10.100.100.13:2380 | https://10.100.100.13:2379 |      false |
+------------------+---------+----------+----------------------------+----------------------------+------------+
```


## Backup

Observe que para esse tipo de manutenção os certificados são **outros**. O endpoint **master02**, foi removido, por isso não foi informado na string de conexão.

#### O disparo do backup pode ser executado em qualquer membro. Afim de testificar, o backup será executado no node ( master03 )

```bash
cat > /root/etcdctl.env <<EOF
export ETCDCTL_ENDPOINTS=https://master01:2379,https://master03:2379
export ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt
export ETCDCTL_CERT=/etc/kubernetes/pki/etcd/healthcheck-client.crt
export ETCDCTL_KEY=/etc/kubernetes/pki/etcd/healthcheck-client.key
EOF

source /root/etcdctl.env
mkdir -p /backup
etcdctl snapshot save /backup/etcd-$(date +%F-%H%M).db
```
