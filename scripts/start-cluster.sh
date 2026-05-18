#!/bin/sh

MK_PROFILE="prestashop"

check_cmd(){
    if ! command -v "$@" > /dev/null; then
        echo 'Missing "$@" command'
        exit 1
    fi
}

diag(){
    kubectl get nodes
}

check_cmd kubectl
check_cmd minikube
check_cmd jq
check_cmd docker



# jq syntax: root->valid[], there check if any item has this value under key 'Name', if so return true
# --arg allows to use argument expansion in the jq epxression
# -e returns exit code 0 if true, non-zero if false
if ! minikube profile list --output json |
  jq -e --arg profile "$MK_PROFILE" 'any(.valid[]; .Name == $profile)' >/dev/null
then
    echo "Starting minikube cluster"
    minikube start --cni=calico --driver=docker --nodes=1 --profile "$MK_PROFILE"
    kubectl wait --for=condition=Ready nodes/"$MK_PROFILE" && echo "Node is ready"

    echo "Enabling addons"

    minikube addons -p "$MK_PROFILE" enable csi-hostpath-driver
    minikube addons -p "$MK_PROFILE" enable volumesnapshots

    # Set's new profile as default
    minikube profile "$MK_PROFILE"
    diag
    exit 0
else
    echo "The cluster is already running"
    diag
    exit 0
fi
