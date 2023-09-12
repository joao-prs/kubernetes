# Guia de Conceitos

### Sumário
- <a href="https://github.com/joao-prs/kubernetes">Voltar para o início.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes1.26.md">Guia de instalação.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes1.26-extras.md">Conteúdo extra.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes.manifest.md">Arquivo Manifesto.</a>

### Pod
representa a unidade mais simples e básica de implantação no Kubernetes. Ele é usado para definir um único contêiner ou um grupo de contêineres que compartilham o mesmo ambiente de execução.

#### YAML
```yml
apiVersion: v1
kind: Pod
metadata:
  name: meu-pod
```

### Deployment 
é usado para definir como um aplicativo deve ser implantado e gerenciado no Kubernetes. Ele permite a atualização e o dimensionamento de réplicas de pods de maneira controlada.

#### YAML
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: meu-deployment
```

### Service
define uma abstração de rede que permite que pods se comuniquem entre si ou com o mundo exterior. Ele é usado para expor aplicativos em um cluster Kubernetes.

#### YAML
```yml
apiVersion: v1
kind: Service
metadata:
  name: meu-servico
```

### Namespace
espaço lógico isolado dentro de um cluster Kubernetes. Ele é usado para organizar recursos e separar diferentes aplicativos ou equipes.

#### YAML
```yml
apiVersion: v1
kind: Namespace
metadata:
  name: meu-namespace
```
