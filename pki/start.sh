#!/bin/bash

server=${1:-cuddletech}
docker rm -f nginx

#    -v ~/study/vault/hands-on-vault/selfsigned-pki/nginx/nginx.conf:/etc/nginx/nginx.conf \
docker run -tid --name nginx -p 80:80 -p 443:443 \
    -v ~/study/vault/hands-on-vault/pki/${server}/nginx/ssl.conf:/etc/nginx/conf.d/default.conf \
    -v ~/study/vault/hands-on-vault/pki/${server}/nginx/certs:/etc/nginx/certs \
    nginx
