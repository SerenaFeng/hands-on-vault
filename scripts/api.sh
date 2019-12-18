#!/bin/bash

dir=$(dirname $0)

source ${dir}/env.sh
token=${VAULT_TOKEN}
method="GET"

resource=${1}; shift

if [[ $1 == "-t" ]]; then
  shift;
  token=$1;
  shift
fi

if [[ $1 == "-r" ]]; then
  shift;
  method=$1;
  shift
fi
options="$@"

cmd="curl --header \"X-Vault-Token: ${token}\" --request ${method} ${options} ${VAULT_ADDR}/v1/${resource} | jq "

echo $cmd

eval ${cmd}
