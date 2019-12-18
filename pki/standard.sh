#!/bin/bash

docker rm -f standard

#    -v ~/study/vault/hands-on-vault/selfsigned-pki/nginx/nginx.conf:/etc/nginx/nginx.conf \
docker run -tid --name standard -p 80:80 \
    -v ~/study/vault/hands-on-vault/selfsigned-pki/nginx/standard.conf:/etc/nginx/nginx.conf \
    nginx
