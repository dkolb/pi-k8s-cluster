#!/bin/bash

echo "Installing flux"

REPO_ROOT=$(git rev-parse --show-toplevel)

echo "Applying namespace yaml..."

kubectl get namespace flux
FLUX_NS_EXISTS=$?

if [ "$FLUX_NS_EXISTS" -ne 0 ]; then
  kubectl create namespace flux
fi

echo "Creating ssh key..."

KEYFILE=$(tempfile)
rm "$KEYFILE"

kubectl -n flux get secret flux-ssh
SSH_SECRET_EXISTS=$?

if [ "$SSH_SECRET_EXISTS" -ne 0 ]; then
  ssh-keygen -q -N "" -f "$KEYFILE"
  kubectl -n flux delete secret generic flux-ssh --ignore-not-found
  kubectl -n flux create secret generic flux-ssh --from-file="deploy-key=$KEYFILE" --from-file="pub-key=$KEYFILE.pub"
  echo "Add the following to your repo as a deployment key with write access."
  echo "==================BEGIN PUBLIC KEY=================="
  cat "$KEYFILE.pub"
  echo "================== END PUBLIC KEY =================="

  read -p "Press enter to continue..."

  rm "$KEYFILE"*
fi

echo "Installing flux helm chart..."

helm repo add fluxcd https://charts.fluxcd.io
helm repo update
helm upgrade --install flux --values "${REPO_ROOT}/deployments/flux/flux/flux-values.yaml" --namespace flux fluxcd/flux