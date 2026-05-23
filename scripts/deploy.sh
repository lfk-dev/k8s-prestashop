#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
K8S="$SCRIPT_DIR/../k8s"

set -x # prints the command itself
kubectl apply -f "${K8S}/Namespace.yaml"

kubectl apply -f "${K8S}/StatefulSet.yaml"

kubectl apply -f "${K8S}/Services.yaml"

kubectl apply -f "${K8S}/NetworkPolicy.yaml"

kubectl apply -f "${K8S}/Deployment.yaml"
set +x

echo "Waiting for the deployment..."
kubectl rollout status deployment prestashop -n prestashop --timeout=90s

echo "Finished deployment"
