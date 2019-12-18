#!/bin/bash

#kubectl port-forward vault-0 --address 0.0.0.0 $1:8200 &
port=${1:-8200}
sealfile=${2:-${SEALFILE}}

unset VAULT_ADDR VAULT_TOKEN
export VAULT_ADDR=http://127.0.0.1:${port}

[ -n ${sealfile} ] || {
  export VAULT_TOKEN=$(cat ${sealfile} | jq .root_token | tr -d \")
}
