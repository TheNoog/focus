#!/bin/bash


# Official instructions - https://microk8s.io/docs - snap info microk8s
sudo snap install microk8s --classic --channel=1.27/stable

# Add the current user to the group, and reload the group
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
newgrp microk8s

# Following to fix calico IPv4 issue.
# microk8s kubectl set env daemonset/calico-node -n kube-system IP_AUTODETECTION_METHOD=interface=eth.*,en.*,em.*,wl.*

# Start it up
microk8s start

# Enable what we want to use. For a list run -> microk8s status
microk8s enable dns dashboard storage registry rbac helm3 
#istio

# Add the extra dashboard service - dashboard on port 30000
microk8s kubectl apply -f ./mk8s/svc_dashboard.yaml --namespace=kube-system

# Copy the kubeconfig to make it easier to login - /var/snap/microk8s/current/credentials/client.config 
cp /var/snap/microk8s/current/credentials/client.config ~/

# Check everything
microk8s kubectl get pods --all-namespaces

# Both Istio and Kubeflow appear to crash Microk8s.
# microk8s enable gpu  # - for kubeflow.
# Only enable kubeflow once everything else is running or it will FAIL!
# microk8s enable kubeflow  # echo "Ambassador Port (ie 30124), JupyterHub port 31000"
# sudo snap install juju --classic  # https://juju.is/docs/olm/installing-juju

microk8s kubectl get svc -n kubeflow