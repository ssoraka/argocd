#!/bin/bash
export INSTALL_K3S_EXEC="--write-kubeconfig /home/vagrant/.kube/config --write-kubeconfig-mode 666 --bind-address 0.0.0.0 --node-ip=192.168.42.110"
curl -sfL https://get.k3s.io | sh -
NODE_TOKEN="/var/lib/rancher/k3s/server/node-token"
while [ ! -e ${NODE_TOKEN} ]
do
  sleep 2
done
cat ${NODE_TOKEN}
cp ${NODE_TOKEN} /home/vagrant/
chown vagrant:vagrant /home/vagrant/node-token
systemctl stop firewalld
systemctl disable firewalld
