#!/bin/bash

export SEALFILE=unseal-`date +%j-%H-%M`.json

vault operator init -key-shares 1 -key-threshold 1 -format json | tee ${SEALFILE}

echo "vault is initialized, message is saved to ${SEALFILE}"

ukey=$(cat ${SEALFILE} | jq .unseal_keys_b64[0] | tr -d \")
echo "unseal vault using ${ukey}"
vault operator unseal ${ukey}

rtoken=$(cat ${SEALFILE} | jq .root_token | tr -d \")
echo "login vault with root token ${rtoken}"
vault login ${rtoken}

