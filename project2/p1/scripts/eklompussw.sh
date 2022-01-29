#!/bin/bash
scp -i /home/vagrant/.ssh/master.key -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@192.168.42.110:/home/vagrant/node-token /home/vagrant/
export INSTALL_K3S_EXEC="--node-ip=192.168.42.111"
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.42.110:6443 K3S_TOKEN_FILE=/home/vagrant/node-token sh -
