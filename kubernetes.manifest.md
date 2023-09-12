# Guia do manifesto

### Sumário
- <a href="https://github.com/joao-prs/kubernetes">Voltar para o início.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes1.26.md">Guia de instalação.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes1.26-extras.md">Conteúdo extra.</a>

### Criação simples
Criar um namespace
```yml
apiVersion: v1
kind: Namespace ## tipo de objeto (deve ser Namespace)
metadata:
  name: meu-namespace ## nome do seu ns
```

### Aplicando o manifesto
Agora que seu arquivo está pronto, construa ele executando o seguinte comando:
```bash
kubectl apply -f my-application.yml
```

Supondo que você queira destruir apenas do seu arquivo:
```bash
kubectl delete -f my-application.yml
```
