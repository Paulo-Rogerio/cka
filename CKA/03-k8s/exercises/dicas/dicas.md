# 🚀 Dicas

#### O que tem no metadata?

Nome do objeto, label, namespace, anotation, geralmente o que é usado para identificar meu objeto.

Donwload do [Krew](https://krew.sigs.k8s.io/), um gerenciador que auxilia na instalação de plugins.

# Como usar os plugins do krew?

```bash
k krew search | grep neat
k krew install neat
k krew list
```

#### Com esse plugin consigo extrair o manifesto yaml de um pod em execução , sendo que ele ja remove informações desnecessárias , metadados etc.

```bash
k neat <<< $(k get pods -n kube-system metrics-server-755bdffd6c-trrcm -o yaml)
k neat <<< $(k get pods -n kube-system metrics-server-755bdffd6c-trrcm -o yaml) > /tmp/study-k8s/nginx-extract.yaml
```

# Sniff
sniff ( Sobe um sidecar e funciona como um tcpdump )
