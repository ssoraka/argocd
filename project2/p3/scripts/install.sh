#!/bin/sh
export K3D_FIX_DNS=1
export DOCKER_OPTS="--dns=my-private-dns-server-ip --dns=8.8.8.8"
wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
k3d cluster create mycluster -p "8080:80@loadbalancer" -p "8082:443@loadbalancer" -p "8888:8888@loadbalancer"
kubectl create ns argocd
kubectl create ns dev
curl https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml | sed -e 's/\( *\)- argocd-server/&\n\1- --insecure/' | kubectl apply -n argocd -f -
kubectl apply -n argocd -f ../confs/ingress.yaml
