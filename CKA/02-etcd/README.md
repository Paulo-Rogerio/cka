# Debug ETCD Kubelet

Examinar saida de logs

```bash
crictl ps -a | grep etcd
crictl logs 992e3500eddf6
systemctl status kubelet
```
