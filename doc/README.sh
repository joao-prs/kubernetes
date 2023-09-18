#################################
###                           ###
### install simple kubernetes ###
###                           ###
#################################


# step 1 | Update Ubuntu
sudo apt update
sudo apt -y upgrade

# step 2 | Install Docker
sudo apt -y install docker.io
docker ––version

# step 3 | Start and Enable Docker
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker

# step 4 | Install Kubernetes # Enter the following to add a signing key in you on Ubuntu
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add

# step 5 | Add Software Repositories
sudo apt-add-repository "deb http://apt.kubernetes.io/kubernetes-xenial main"

# step 6 | Kubernetes Installation Tools
sudo apt-get install kubeadm kubelet kubectl
sudo apt-mark hold kubeadm kubelet kubectl

# step 7 | Kubernetes Deployment # Start by disabling the swap memory on each server
sudo swapoff –a

# step 8 | Assign Unique Hostname for Each Server Node
sudo hostnamectl set-hostname M1 # master node
sudo hostnamectl set-hostname w1 # worker nde

# step 9 | Initialize Kubernetes on Master Node # Switch to the master server node, and enter the following
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 # similar command

# step 10 | Deploy Pod Network to Cluster
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubectl get pods --all-namespaces

# step 11 | Join the Worker Node to Cluster
kubeadm join --discovery-token abcdef.1234567890abcdef --discovery token-ca-cert-hash sha256:1234..cdef 1.2.3.4:6443 # similar command

kubectl get nodes
# NODE       HOSTNAME      IP ADDRESS  VCPUS  RAM(GB)            OS
# M1    master.teste   192.168.124.10      2     3.75  ubuntu.22.04 
# W1    worker1.teste  192.168.124.21      2     3.75  ubuntu.22.04 
# W2    worker2.teste  192.168.124.22      2     3.75  ubuntu.22.04 















# oficial site
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

kubectl version --client
# or
kubectl version --client --output=yaml


############ or

worker-1
kubectl cluster-info dump

# install kubectl convert plugin
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl-convert"

curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl-convert.sha256"

echo "$(cat kubectl-convert.sha256) kubectl-convert" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl-convert /usr/local/bin/kubectl-convert

kubectl convert --help

rm kubectl-convert kubectl-convert.sha256
























################ Full Cycle
sudo -i
hostname "kube-master" > /etc/hostname

sudo -i
hostname "kube-worker-1" > /etc/hostname



apt update
apt install -y docker.io
apt install -y apt-transport-https ca-certificates curl

curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

apt update

apt install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

##
#
# on master
#
##


kubeadm init





systemctl start kubelet





























