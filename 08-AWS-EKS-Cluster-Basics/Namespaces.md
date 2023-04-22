## Verify pods in kube-system namespace
```t
# Verify System pods in kube-system namespace
kubectl get pods # Nothing in default namespace
kubectl get pods -n kube-system
kubectl get pods -n kube-system -o wide

# Verify Daemon Sets in kube-system namespace
kubectl get ds -n kube-system
Observation: The below two daemonsets will be running
1. aws-node
2. kube-proxy

# Describe aws-node Daemon Set
kubectl describe ds aws-node -n kube-system
Observation: 
1. Reference "Image" value it will be the ECR Registry URL 

# Describe kube-proxy Daemon Set
kubectl describe ds kube-proxy -n kube-system
1. Reference "Image" value it will be the ECR Registry URL 

# Describe coredns Deployment
kubectl describe deploy coredns -n kube-system
```
