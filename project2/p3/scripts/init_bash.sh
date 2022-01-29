#!/bin/bash
sudo -i -u vagrant bash << EOF
echo $PATH
kubectl completion bash >~/kubectl
sudo mv /home/vagrant/kubectl /etc/bash_completion.d/kubectl
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc
EOF
