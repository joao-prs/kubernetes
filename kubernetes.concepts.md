# Guia de Conceitos

### Sumário
- <a href="https://github.com/joao-prs/kubernetes">Voltar para o início.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes1.26.md">Guia de instalação.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes1.26-extras.md">Conteúdo extra.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes.manifest.md">Arquivo Manifesto.</a>

### Este Doc
Nesta página, estarei ensinando alguns conceitos gerais e alguns vagos exemplos.

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

### ConfigMap
No Kubernetes, um ConfigMap é um recurso que permite armazenar configurações ou dados de configuração em formato de chave-valor que pode ser usado por aplicativos em contêineres dentro de pods. O objetivo principal de um ConfigMap é separar a configuração do código do aplicativo, facilitando a modificação das configurações sem a necessidade de redesenhar ou recompilar o aplicativo.
Pode ser usado em aplicações como *Configuração de aplicativo*, *Chaves de API ou tokens*, *Configuração de proxy reverso (Ingress)*, *Configuração do Nginx ou outros servidores web*

#### YAML
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: meu-configmap
data:
  CHAVE1: valor1
  CHAVE2: valor2
```
você pode referenciá-lo em um pod ou em outros recursos do Kubernetes, como Deployment, usando variáveis de ambiente ou montando-o como um volume no pod.

#### YAML
```yml
apiVersion: v1
kind: Pod
metadata:
  name: meu-pod
spec:
  containers:
  - name: meu-container
    image: minha-imagem
    volumeMounts:
    - name: config-volume
      mountPath: /etc/config
  volumes:
  - name: config-volume
    configMap:
      name: meu-configmap
```
Isso permitirá que os dados do ConfigMap sejam acessíveis no caminho /etc/config no pod.

### Secret
é um recurso usado para armazenar dados sensíveis, como chaves de API, senhas, tokens de autenticação e outros dados confidenciais. As Secrets são usadas para garantir que informações sensíveis não sejam expostas em texto simples nos manifestos de pod, configurações ou outros recursos.

As Secrets não fornecem criptografia por si só. Certifique-se de proteger o acesso ao cluster Kubernetes e, quando possível, use serviços de gerenciamento de segredos mais avançados, como o Kubernetes Secrets Store CSI Driver ou integração com soluções externas de gerenciamento de segredos.

#### YAML
```yml
apiVersion: v1
kind: Secret
metadata:
  name: minha-secret
type: Opaque
data:
  username: <base64-encoded-username>
  password: <base64-encoded-password>
```

você pode montá-la como um volume ou definir variáveis de ambiente a partir dela.
```yml
apiVersion: v1
kind: Pod
metadata:
  name: meu-pod
spec:
  containers:
  - name: meu-container
    image: minha-imagem
    volumeMounts:
    - name: secret-volume
      mountPath: /etc/secrets
  volumes:
  - name: secret-volume
    secret:
      secretName: minha-secret
```

Você também pode usar os dados de uma Secret como variáveis de ambiente em um pod.
```yml
apiVersion: v1
kind: Pod
metadata:
  name: meu-pod
spec:
  containers:
  - name: meu-container
    image: minha-imagem
    env:
    - name: USERNAME
      valueFrom:
        secretKeyRef:
          name: minha-secret
          key: username
    - name: PASSWORD
      valueFrom:
        secretKeyRef:
          name: minha-secret
          key: password
```


### StatefulSet
### PersistentVolume
### Ingress