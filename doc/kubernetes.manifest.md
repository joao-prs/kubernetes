# Guia do manifesto

### Sumário
- <a href="https://github.com/joao-prs/kubernetes">Voltar para o início.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/doc/kubernetes1.26.md">Guia de instalação.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/doc/kubernetes.concepts.md">Conceitos básicos.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/doc/kubernetes.manifest.md">Sobre o arquivo de manifesto.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/doc/kubernetes1.26-extras.md">Conteúdo extra.</a>

### Aplicando o manifesto
Construa ele executando o seguinte comando:
```bash
kubectl apply -f my-application.yml
```

Supondo que você queira destruir apenas do seu arquivo:
```bash
kubectl delete -f my-application.yml
```
