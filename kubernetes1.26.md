# Guia de instalação

<div align="center" style="align-items: flex-start;"><img src="https://techstack-generator.vercel.app/kubernetes-icon.svg" alt="icon" width="65" height="65" /></div>

### Sumário
- <a href="https://github.com/joao-prs/kubernetes">Voltar para o início.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes.concepts.md">Conceitos básicos.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes.manifest.md">Arquivo Manifesto.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes1.26-extras.md">Conteúdo extra.</a>

### Primeiros passos

executar todos comandos a seguir em todos os nodes do cluster
```bash
sudo swapoff -a

cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# aplica alteração sem precisar reiniciar
sudo sysctl --system
```

Instale algumas ferramentas
```bash
sudo apt update && sudo apt install ca-certificates curl gnupg lsb-release -y
```

configure o repositório
```bash
sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | 	sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# finalize com...
sudo apt update
```

Instale e configure o CRI
```bash
sudo apt install -y containerd.io -y

sudo mkdir -p /etc/containerd && containerd config default | sudo tee /etc/containerd/config.toml

sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml

sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml

sudo systemctl restart containerd

sudo systemctl status containerd
```

Instalação do kubeadm, kubelet and kubectl
```bash
sudo apt-get update && \
sudo apt-get install -y apt-transport-https ca-certificates curl

curl -fsSL https://dl.k8s.io/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update && \
sudo apt-get install -y kubelet kubeadm kubectl 

#trava versao
sudo apt-mark hold kubelet kubeadm kubectl
```

### Iniciando o cluster Kubernetes
execute os comandos a seguir apenas no control plane
```bash
kubeadm init
# pode ocorrer erros, siga as orientações
```

o k8s irá retornar alguns comandos que voce deve executar, devem ser semelhantes a esses:
```bash
# To start using your cluster, you need to run the following as a regular user:

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Alternatively, if you are the root user, you can run:

export KUBECONFIG=/etc/kubernetes/admin.conf

#You should now deploy a pod network to the cluster.
#Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
#  https://kubernetes.io/docs/concepts/cluster-administration/addons/

#Then you can join any number of worker nodes by running the following on each as root:

#kubeadm join 172.18.36.100:6443 --token jqqhf2.vnduf7rghio6mdh2 \
#	--discovery-token-ca-cert-hash sha256:959461ae24a0f6810bbf6a1359d6a631438b1f34a5c0ca151089bd7578dfc695
```
> comentei as linhas menos importantes do output, mas as deixei para que você possa comparar


### Container Network Interface CNI
Instale uma interface de rede para o kubernetes
```bash
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

# espere um tempo e ...
kubectl get nodes
```

> Pronto, você finalizou a instalação do kubernetes, agora você pode utilizado para testes e labs. Para um ambiente mais avançado, pesquise recursos mais otimizados e tenha disponivel um bom computador ou servidor com recursos abundantes para laboratórios mais complexos e que tenha suporte a cargas maiores de trabalho. 
