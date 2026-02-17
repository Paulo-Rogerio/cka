# 🚀 Remove Member Etcd

- [1) ETCD StaticPod](#1-etcd-staticpod)
- [1.1) Check Status Backup Etcd](#11-check-status-backup-etcd)
- [1.2) Restore Backup Etcd](#12-restore-backup-etcd)
- [1.3) Replace Manifests Yaml Etcd](#13-replace-manifests-yaml-etcd)


## 1) ETCD StaticPod

O procedimento abaixo irá remover todos os dados de todos os membros. Isso irá deixar o cluster inutilizável.

## 1.1) Check Status Backup Etcd

Check o status do backup. Como o backup foi realizado no node **master03**, esse script identifica que o backup não está presente no host e copia para membro em questão.

```bash
cd /root/kubernetes-certifications/CKA/02-etcd/etcd-manager/cluster/staticPod/restore

sh 01-status-backup.sh

#################################################
 Esse script deve ser executa a cada node
#################################################
+----------+----------+------------+------------+---------+
|   HASH   | REVISION | TOTAL KEYS | TOTAL SIZE | VERSION |
+----------+----------+------------+------------+---------+
| b54064ca |       13 |          8 |      20 kB |   3.6.0 |
+----------+----------+------------+------------+---------+
```

## 1.2) Restore Backup Etcd

#### OBS.: OS PROCEDIMENTOS ABAIXO PODEM SER FEITOS EM QUALQUER UM DOS MEMBROS. TODOS OS NODES SE COMUNICAM POR CHAVE.

## 1.3) Replace Manifests Yaml Etcd

```bash
```
