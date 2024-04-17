#!/usr/bin/env bash

set -e
set -u
set -o pipefail

X_NAME="${1}"

flux bootstrap github \
  --token-auth \
  --owner=registry-operator \
  --repository=dev-infra \
  --branch=main \
  --path="clusters/${X_NAME}"
