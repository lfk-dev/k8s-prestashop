# Kubernetes deployment of prestashop

## Overview
This is a simple, local deployment of prestashop using minikube.

## How to deploy
```bash
./scripts/start-cluster.sh

./scripts/deploy.sh

# To delete the cluster
./scripts/destroy-cluster.sh

# To access prestashop admin panel
minikube ip

# Enter `<minikube_IP>:30333/admin-dev` into a browser
# Default credentials:
# Email: demo@prestashop.com
# Password: prestashop_demo
```

## Features
1. Kubernetes native deployment of Prestashop to single node using minikube
2. `csi-hostpath-driver` used for persitance on the node's storage
3. **StatefulSet** and **Deployment** resources
4. Network Policy targeting MySQL pods

## Roadmap
1. Snapshot backups for MySQL PVC
2. Init container for prestashop waiting for MySQL
3. NetworkPolicy for Prestashop pods
4. Improve scripts logging
5. Port forwarding with minikube (makes PS reachable under `localhost` not `<minikube_IP>`)
