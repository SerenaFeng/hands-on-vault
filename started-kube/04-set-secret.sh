vault secrets enable -path=secret kv-v2
vault kv put secret/exampleapp/config username="helmchart" password="secrets"
vault kv get secret/exampleapp/config

