#git clone https://github.com/hashicorp/vault-helm.git /tmp/vault-helm

cd /tmp/vault-helm
helm upgrade --install --set 'server.authDelegator.enabled=false' --set 'server.dataStorage.enabled=false' vault ./

while true; do
  kubectl get po vault-0 | tail -1 | grep Running
  [[ $? == 0 ]] && break
  echo "vault-0 not ready"
  sleep 3
done

echo "vault is sucessfully installed"

