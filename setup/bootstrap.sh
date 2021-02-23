#!/bin/bash

REPO_ROOT=$(git rev-parse --show-toplevel)

echo "Bootstrapping flux..."

pushd $REPO_ROOT

mkdir -p "$REPO_ROOT"/deployments/flux-system/

flux install --version=latest \
  --watch-all-namespaces \
  --export > ./deployments/flux-system/gotk-components.yaml

kubectl apply -f "$REPO_ROOT"/deployments/flux-system/gotk-components.yaml

flux create source git flux-system \
  --url=ssh://git@github.com/dkolb/pi-k8s-cluster \
  --branch=main

flux create kustomization flux-system \
  --source=flux-system \
  --path="./deployments" \
  --prune=true \
  --interval=10m

flux export source git flux-system \
  > "$REPO_ROOT"/deployments/flux-system/gotk-sync.yaml

flux export kustomization flux-system \
  >> "$REPO_ROOT"/deployments/flux-system/gotk-sync.yaml

popd