# Guia de Conceitos

### Sumário
- <a href="https://github.com/joao-prs/kubernetes">Voltar para o início.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/doc/kubernetes1.26.md">Guia de instalação.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/doc/kubernetes.some.manifest.md">Exemplo manifesto.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/doc/kubernetes.manifest.md">Sobre o arquivo de manifesto.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/doc/kubernetes1.26-extras.md">Conteúdo extra.</a>


### Interfaces do kubernetes
Para que o k8s não precise de um grande binário, você pode customizá-lo com partes de ferramentas que faz o cluster ser possível, essas partes são chamadas de interface.
- CRI (Container Runtime Interface) exemplos: containerd...
- CNI (Container Network Interface) exemplos: wavenet, calico, flannel...
- CSI (Container Storage Interface) exemplos: public cloud, longhorn, glusterFS...

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
é usado para gerenciar aplicativos com estados, como bancos de dados e outros sistemas que mantêm dados persistentes. Ao contrário de outros controladores, como Deployments, que são usados para aplicativos sem estado, o StatefulSet fornece garantias específicas em relação à ordem de inicialização, identidade persistente e nomes de serviço para pods em seu conjunto. 

As principais características são *Identidade persistente*, *Ordem de inicialização controlada*, *Persistência de volumes* e *Nomes de serviço previsíveis*.

#### YAML
```yml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: meu-statefulset
spec:
  replicas: 3 ## numero de réplicas
  serviceName: meu-statefulset-svc ## nome do teu serviço
  selector:
    matchLabels:
      app: meu-app
  template:
    metadata:
      labels:
        app: meu-app
    spec:
      containers:
      - name: meu-container
        image: minha-imagem
        ports:
        - containerPort: 80
  ## cada pod terá um volume persistente chamado "meu-volume" com capacidade de 1Gi
  volumeClaimTemplates:
  - metadata:
      name: meu-volume
    spec:
      accessModes: [ "ReadWriteOnce" ]
      storageClassName: meu-sc
      resources:
        requests:
          storage: 1Gi
```
Ele é frequentemente usado para implementar sistemas de banco de dados, servidores de mensagens e outros aplicativos que requerem essas garantias.

### PersistentVolume
é um recurso que representa uma unidade de armazenamento física no cluster. Ele é usado para abstrair detalhes específicos de armazenamento e fornecer um mecanismo de alocação dinâmica ou estática de armazenamento para pods. Os PersistentVolumes são uma parte importante da gestão de armazenamento persistente em aplicativos Kubernetes.

- **PersistentVolume (PV)**: É a representação abstrata de um volume de armazenamento físico. Um PV pode ser configurado manualmente por um administrador de cluster ou provisionado dinamicamente por um controlador de provisionamento de armazenamento, dependendo da infraestrutura subjacente do cluster.

- **PersistentVolumeClaim (PVC)**: É uma solicitação feita por um usuário ou um aplicativo para reservar uma quantidade específica de armazenamento. Os PVCs são usados pelos pods para solicitar acesso a um PV com determinadas características (como capacidade, modo de acesso e modo de retenção).

- **Classe de armazenamento (StorageClass)**: É um recurso que define as propriedades e os parâmetros para a alocação dinâmica de PVs. As classes de armazenamento permitem que os administradores definam políticas de provisionamento e forneçam opções de armazenamento personalizadas para diferentes aplicativos.

### Ingress
é um recurso que gerencia o acesso externo a serviços dentro de um cluster Kubernetes. Ele atua como uma camada de abstração entre os serviços internos do cluster e o tráfego externo, permitindo o roteamento de solicitações HTTP e HTTPS para serviços específicos com base em regras de configuração.

- **Ingress Controller**: controlador de Ingress em execução no cluster. O controlador de Ingress é responsável por implementar as regras de configuração definidas nos recursos de Ingress em serviços ou outros recursos de Kubernetes.

- **Regras de Ingress**: regras especificam como o tráfego externo deve ser roteado para serviços internos. correspondência de caminhos URL, cabeçalhos HTTP, redirecionamento para URLs diferentes e muito mais.

- **TLS/SSL Termination**: suportam a terminação SSL/TLS, permitindo que você forneça suporte HTTPS para seus serviços sem que os pods subjacentes precisem lidar com a criptografia SSL/TLS.


[Voltar para o topo](#guia-de-conceitos)
