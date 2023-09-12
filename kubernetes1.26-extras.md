# Conteúdo Extra

<div  align="center" style="align-items: flex-start;"><img src="https://techstack-generator.vercel.app/kubernetes-icon.svg" alt="icon" width="65" height="65" /></div>

### Sumário
- <a href="https://github.com/joao-prs/kubernetes">Voltar para o início.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes1.26.md">Guia de instalação.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes.concepts.md">Conceitos básicos.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes.manifest.md">Arquivo Manifesto.</a>

### comandos extras

```bash
# execute no control-plane
kubeadmin token create --print-join-command

kubectl get nodes

kubectl get all -n kube-system
```

```bash
kubectl get namespaces
kubectl get ns
# pega namespaces

kubectl get pods -A
# ou --all-namespaces=false

kubectl describe pods -n <namespace> <pod>
#exibi detalhes do pod, exemplo de comando abaixo
kubectl describe pods -n portainer portainer-agent-5d979d5f6b-6zvkd
```

lab rapido
```bash
kubectl run nginx --image nginx
kubectl get pods
kubectl expose pod nginx --port="80"
kubectl delete pods nginx
```


atalhos
```bash
kubectl get pods
kubectl get po

kubectl get service
kubectl get svc

kubectl get deployment
kubectl get deploy

kubectl get namespace
kubectl get ns
```

expor para ser acessivel fora do cluster
```bash
kubectl expose pod nginx --type NodePort
```

> Organização chegará neste documento em breve