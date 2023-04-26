# To create a configMap
cat <<EOF> app.properties
driver=jdbc
databases=postgres
EOF

```sh
kubectl create configmap app-config --from-file=app.properties
```

### To list configmap
kubectl get configmap

kubectl get configmap nginx-config -o yaml 

### To curl a url with host 
curl 192.168.10.126 -H 'Host: helloworld-v1.example.com'
