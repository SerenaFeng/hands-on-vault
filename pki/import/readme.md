1. create pki backend

```
  $ vault secrets enable -path=import_pki pki
```

2. create self-signed certificate

```
  $ openssl genrsa -out rootca.key 2048
  $ openssl req -x509 -new -nodes -key rootca.key -sha256 -days 1024 -out rootca.pem
```

3. create a json file rootca-bundle.json (could be of any name) consisting of "pem_bundle" attribute having value of the concatenation result of rootca.key & rootca.pem

4. Upload the root certificate into the Vault

```
  $ curl --header "X-Vault-Token: $VAULT_TOKEN" --request POST  --data "@rootca-bundle.json" $VAULT_ADDR/v1/import_pki/config/ca
```

5. Creating rule

```
  $ curl --header "X-Vault-Token: $VAULT_TOKEN" --request POST  --data "@role.json" $VAULT_ADDR/v1/import_pki/roles/import-pki
```

6. Create Certificate Signing Request(CSR) using openssl that we wish to sign using the Vault CA created above

```
  $ openssl genrsa -out sign.key 2048
  $ openssl req -new -key sign.key -out sign.csr
```

7. Get the certificate signed

```
  $ vault write import_pki/sign/import-pki csr=@sign.csr common_name="10.62.105.17" ttl=720h format=pem
```

8. Create a certificate file sign.crt concatenating the certificate & issue_ca section created above

9. Copy sign.crt & sign.key to /etc/nginx/certs
