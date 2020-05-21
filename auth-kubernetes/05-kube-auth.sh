#!/bin/bash

unset VAULT_SA VAULT_SECRET VAULT_SA_CA_CRT VAULT_SA_CA_CRT K8S_URL
export VAULT_SA=${1:-vault-auth}

vault auth disable kubernetes
vault auth enable kubernetes
kubectl create sa ${VAULT_SA} || true
export VAULT_SECRET=$(kubectl get sa ${VAULT_SA} -o jsonpath="{.secrets[*]['name']}")
export VAULT_SA_JWT=$(kubectl get secret $VAULT_SECRET -o jsonpath="{.data.token}" | base64 --decode)
export VAULT_SA_CA_CRT=$(kubectl get secret $VAULT_SECRET -o jsonpath="{.data['ca\.crt']}" | base64 --decode)
export K8S_URL=$(kubectl config view --minify -o json | jq .clusters[0].cluster.server | tr -d \")

echo "configuring k8s: $K8S_URL"

echo "config k8s auth method in vault"
vault write auth/kubernetes/config \
  token_reviewer_jwt="$VAULT_SA_JWT" \
  kubernetes_host="$K8S_URL" \
  kubernetes_ca_cert="$VAULT_SA_CA_CRT"

echo "config vault example policy"
vault policy write example - <<EOH
path "secret/data/example/config" {
  capabilities = ["read"]
}
EOH

echo "config k8s example role"
vault write auth/kubernetes/role/example \
  bound_service_account_names=${VAULT_SA} \
  bound_service_account_namespaces=default \
  policies="default,example" \
  ttl=24h

echo "bind auth-delegator role to vault service account"
kubectl apply -f $(dirname ${0})/../manifests/vault-auth-delegator.yaml
