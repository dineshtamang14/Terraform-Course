# kubernetes notes

### To Label a node
kubectl label nodes node1 hardware=high-spec
kubectl label nodes noe2 hardware=low-spec

### To deploy pod in spec node
nodeSelector:
    hardware: high-spec

### To watch a live pods
kubectl create -f helloworld.yml && watch -n1 kubectl get pods

### Pod LifeCycle

i. init container

Main-container
 i. post start hook
 ii. initialDelaySeconds
      a. readiness probe
      b. liveness probe
 iii. pre stop hook

### To store secrets in kubernetes
echo -n "root" > ./username.txt
echo -n "password" > ./password.txt
kubectl create secret generic db-user-pass -from-file=./username.txt --from-file=./password.txt


