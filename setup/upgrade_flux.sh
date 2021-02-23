#!/bin/bash
REPO_ROOT=$(git rev-parse --show-toplevel)

pushd $REPO_ROOT

flux install --version=latest \
  --watch-all-namespaces \
  --export > ./deployments/flux-system/gotk-components.yaml

kubectl apply -f "$REPO_ROOT"/deployments/flux-system/gotk-components.yaml

popd