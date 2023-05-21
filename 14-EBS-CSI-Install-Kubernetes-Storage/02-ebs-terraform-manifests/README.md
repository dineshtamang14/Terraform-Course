 Verify EBS CSI Outputs
Mainly verify the output related to HELM RELEASE named "ebs_csi_helm_metadata"
```
## Verify EBS CSI Driver Install on EKS Cluster
```t
# Configure kubeconfig for kubectl (Optional - If already not configured)
aws eks --region <region-code> update-kubeconfig --name <cluster_name>
aws eks --region us-east-1 update-kubeconfig --name hr-dev-eksdemo1

# Verify Kubernetes Worker Nodes using kubectl
kubectl get nodes
kubectl get nodes -o wide

# Verify EBS CSI Pods
kubectl -n kube-system get pods 
Observation: We should see below two pod types from EBS CSI Driver running in kube-system namespace
1. ebs-csi-controller pods
2. ebs-csi-node pods
```

## Describe EBS CSI Controller Deployment
```t
# Describe EBS CSI Deployment
kubectl -n kube-system get deploy 
kubectl -n kube-system describe deploy ebs-csi-controller 

Observation: ebs-csi-controller Deployment 
1. ebs-csi-controller deployment creates a pod which is a multi-container pod
2. Rarely we get in Kubernetes to explore Multi-Container pod concept, so lets explore it here.
3. Each "ebs-csi-controller", contains following containers
  - ebs-plugin
  - csi-provisioner
  - csi-attacher
  - csi-resizer
  - liveness-probe
```
## Describe EBS CSI Controller Pod
```t
# Describe EBS CSI Controller Pod
kubectl -n kube-system get pods 
kubectl -n kube-system describe pod ebs-csi-controller-56dfd4fccc-7fgbr

Observations:
1. In the Pod Events, you can multiple containers will be pulled and started in a k8s Pod
```

## Verify Container Logs in EBS CSI Controller Pod
```t
# Verify EBS CSI Controller Pod logs
kubectl -n kube-system get pods
kubectl -n kube-system logs -f ebs-csi-controller-56dfd4fccc-7fgbr

# Error we got when checking EBS CSI Controller pod logs
$ kubectl -n kube-system logs -f ebs-csi-controller-56dfd4fccc-7fgbr
error: a container name must be specified for pod ebs-csi-controller-56dfd4fccc-7fgbr, choose one of: [ebs-plugin csi-provisioner csi-attacher csi-resizer liveness-probe]
Kalyans-MacBook-Pro:02-ebs-terraform-manifests kdaida$ 

# Verify logs of liveness-probe container in EBS CSI Controller Pod
kubectl -n <NAMESPACE> logs -f <POD-NAME> <CONTAINER-NAME>
kubectl -n kube-system logs -f liveness-probe 

# Verify logs of ebs-plugin container in EBS CSI Controller Pod
kubectl -n <NAMESPACE> logs -f <POD-NAME> <CONTAINER-NAME>
kubectl -n kube-system logs -f ebs-csi-controller-56dfd4fccc-7fgbr ebs-plugin 

# Verify logs of csi-provisioner container in EBS CSI Controller Pod
kubectl -n <NAMESPACE> logs -f <POD-NAME> <CONTAINER-NAME>
kubectl -n kube-system logs -f ebs-csi-controller-56dfd4fccc-7fgbr csi-provisioner 

# Verify logs of csi-attacher container in EBS CSI Controller Pod
kubectl -n <NAMESPACE> logs -f <POD-NAME> <CONTAINER-NAME>
kubectl -n kube-system logs -f ebs-csi-controller-56dfd4fccc-7fgbr csi-attacher 

# Verify logs of csi-resizer container in EBS CSI Controller Pod
kubectl -n <NAMESPACE> logs -f <POD-NAME> <CONTAINER-NAME>
kubectl -n kube-system logs -f ebs-csi-controller-56dfd4fccc-7fgbr csi-resizer 
```

## Verify EBS CSI Node Daemonset and Pods
```t
# Verify EBS CSI Node Daemonset
kubectl -n kube-system get daemonset
kubectl -n kube-system get ds
kubectl -n kube-system get pods 
Observation: 
1. We should know that, daemonset means it creates one pod per worker node in a worker node group
2. In our case, we have only 1 node in Worker Node group, it created only 1 pod named "ebs-csi-node-qp426"

# Descrine EBS CSI Node Daemonset (It also a multi-container pod)
kubectl -n kube-system describe ds ebs-csi-node
Observation:
1. We should the following containers listed in this daemonset
 - ebs-plugin 
 - node-driver-registrar 
 - liveness-probe

# Verify EBS CSI Node pods
kubectl -n kube-system get pods 
kubectl -n kube-system describe pod ebs-csi-node-qp426  
Observation:
1. Verify pod events, we can see multiple containers pulled and started in EBS CSI Node pod
```

## Verify EBS CSI Node Pod Container Logs
```t
# Verify EBS CSI Node Pod logs
kubectl -n kube-system logs -f ebs-csi-node-qp426

# Error we got when checking EBS CSI Node pod logs
$ kubectl -n kube-system logs -f ebs-csi-node-qp426
error: a container name must be specified for pod ebs-csi-node-qp426, choose one of: [ebs-plugin node-driver-registrar liveness-probe]
 
# Verify logs of liveness-probe container in EBS CSI Node Pod
kubectl -n <NAMESPACE> logs -f <POD-NAME> <CONTAINER-NAME>
kubectl -n kube-system logs -f ebs-csi-node-qp426 liveness-probe

# Verify logs of ebs-plugin container in EBS CSI Node Pod
kubectl -n <NAMESPACE> logs -f <POD-NAME> <CONTAINER-NAME>
kubectl -n kube-system logs -f ebs-csi-node-qp426 ebs-plugin

# Verify logs of node-driver-registrar container in EBS CSI Node Pod
kubectl -n <NAMESPACE> logs -f <POD-NAME> <CONTAINER-NAME>
kubectl -n kube-system logs -f ebs-csi-node-qp426 node-driver-registrar
```


## Verify EBS CSI Kubernetes Service Accounts
```t
# List EBS CSI  Kubernetes Service Accounts
kubectl -n kube-system get sa 
Observation:
1. We should find two service accounts related to EBS CSI
  - ebs-csi-controller-sa
  - ebs-csi-node-sa

# Describe EBS CSI Controller Service Account
kubectl -n kube-system describe sa ebs-csi-controller-sa
Observation:
1. Verify the "Annotations" field and you should find our IAM Role created for EBS CSI is associated with EKS Cluster EBS Service Account.
Annotations:         eks.amazonaws.com/role-arn: arn:aws:iam::180789647333:role/hr-dev-ebs-csi-iam-role
2. Also review the labels
Labels:              app.kubernetes.io/component=csi-driver
                     app.kubernetes.io/instance=hr-dev-aws-ebs-csi-driver
                     app.kubernetes.io/managed-by=Helm
                     app.kubernetes.io/name=aws-ebs-csi-driver
                     app.kubernetes.io/version=1.5.0
                     helm.sh/chart=aws-ebs-csi-driver-2.6.2


# Describe EBS CSI Node Service Account
kubectl -n kube-system describe sa ebs-csi-node-sa
Observation: 
1. Observe the labels
Labels:              app.kubernetes.io/component=csi-driver
                     app.kubernetes.io/instance=hr-dev-aws-ebs-csi-driver
                     app.kubernetes.io/managed-by=Helm
                     app.kubernetes.io/name=aws-ebs-csi-driver
                     app.kubernetes.io/version=1.5.0
                     helm.sh/chart=aws-ebs-csi-driver-2.6.2
```

## References
- [AWS IAM OIDC Connect Provider - Step-3](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html)
- [AWS EBS CSI Driver](https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html)
- [AWS Caller Identity Datasource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)
- [HTTP Datasource](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http)
- [AWS IAM Role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)
- [AWS IAM Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)
- [AWS EBS CSI Docker Images across Regions](https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html)
- [List All Container Images Running in a Cluster](https://kubernetes.io/docs/tasks/access-application-cluster/list-all-running-container-images/)

