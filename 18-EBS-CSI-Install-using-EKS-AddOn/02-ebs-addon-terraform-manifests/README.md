## Verify EBS CSI Driver installed via EKS Addon
```t
# EKS List AddOns for a EKS Cluster
aws eks list-addons --cluster-name hr-dev-eksdemo1

## Sample Output
{
    "addons": [
        "aws-ebs-csi-driver"
    ]
}

# Configure kubeconfig for kubectl
aws eks --region <region-code> update-kubeconfig --name <cluster_name>
aws eks --region us-east-1 update-kubeconfig --name hr-dev-eksdemo1

# List EBS Pods from kube-system namespace
kubectl -n kube-system get pods 

# List EBS Deployment from kube-system namespace
kubectl -n kube-system get deploy 

# List EBS Daemonset from kube-system namespace
kubectl -n kube-system get ds
```
