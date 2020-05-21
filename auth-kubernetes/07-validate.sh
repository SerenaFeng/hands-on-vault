podname=$(kubectl get po -l app=exampleapp -o=jsonpath="{.items[0].metadata.name}")
echo $podname
kubectl port-forward ${podname} 8080:8080 &>/dev/null &

sleep 1
curl http://localhost:8080
echo ""
ps -ef | grep ${podname} | grep -v grep | awk '{print $2}' | xargs sudo kill -kill &>/dev/null
