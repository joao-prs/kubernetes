# Extras

### comandos extras


```bash
# execute no control-plane
kubeadmin token create --print-join-command

kubectl get nodes

kubectl get all -n kube-system
```


```bash
kubectl get ns
# pega namespaces

kubectl get pods -A
# ou --all-namespaces=false
```