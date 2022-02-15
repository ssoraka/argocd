#!/usr/bin/env bash

# cluster
k3d cluster create mycluster --servers 1 --agents 0 -p "8080:80@loadbalancer" -p "8082:443@loadbalancer" -p "8888:8888@loadbalancer"

# namespace
kubectl create namespace argocd
kubectl create namespace dev

#
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# for an IngressRoute type
# kubectl wait --for=condition=complete --timeout=300s -n kube-system job.batch/helm-install-traefik-crd
curl https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml | sed -e 's/\( *\)- argocd-server/&\n\1- --insecure/' | kubectl apply -n argocd -f -
sleep 3
kubectl apply -f /vagrant/confs/ingress.yaml
kubectl apply -f /vagrant/confs/argo.yaml
