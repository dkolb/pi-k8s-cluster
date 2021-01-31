#!/bin/bash

REPO_ROOT=$(git rev-parse --show-toplevel)

echo "Bootstrapping flux..."

pushd $REPO_ROOT/deployments
mkdir -p flux-system/

flux install --version=latest \
  --watch-all-namespaces \
  --export > ./flux-system/gotk-components.yaml

popd

kubectl apply -f "$REPO_ROOT"/deployments/flux-system/gotk-components.yaml

flux create source git flux-system \
  --url=ssh://git@github.com/dkolb/pi-k8s-cluster \
  --branch=main

flux create kustomization flux-system \
  --source=flux-system \
  --path="./deployments" \
  --prune=true \
  --interval=10m