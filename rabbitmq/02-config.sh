#!/bin/bash

vault secrets disable rabbitmq
vault secrets enable rabbitmq

vault write rabbitmq/config/connection \
  connection_uri="http://10.62.105.17:15672" \
  username="guest" \
  password="guest"

vault write rabbitmq/roles/my-role \
  vhosts='{"/": {"write": ".*", "read": ".*", "configure": ".*"}}'
vault read rabbitmq/creds/my-role
