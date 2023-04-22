## Connect to EKS Worker Nodes using Bastion Host
```t
# Connect to Bastion EC2 Instance
ssh -i private-key/eks-terraform-key.pem ec2-user@<Bastion-EC2-Instance-Public-IP>
cd /tmp

# Connect to Kubernetes Worker Nodes - Public Node Group
ssh -i private-key/eks-terraform-key.pem ec2-user@<Public-NodeGroup-EC2Instance-PublicIP> 
[or]
ec2-user@<Public-NodeGroup-EC2Instance-PrivateIP>

# Connect to Kubernetes Worker Nodes - Private Node Group from Bastion Host
ssh -i eks-terraform-key.pem ec2-user@<Private-NodeGroup-EC2Instance-PrivateIP>

##### REPEAT BELOW STEPS ON BOTH PUBLIC AND PRIVATE NODE GROUPS ####
# Verify if kubelet and kube-proxy running
ps -ef | grep kube

# Verify kubelet-config.json
cat /etc/kubernetes/kubelet/kubelet-config.json

# Verify kubelet kubeconfig
cat /var/lib/kubelet/kubeconfig

# Verify clusters.cluster.server value(EKS Cluster API Server Endpoint)  DNS resolution which is taken from kubeconfig
nslookup <EKS Cluster API Server Endpoint>
nslookup CF89341F3269FB40F03AAB19E695DBAD.gr7.us-east-1.eks.amazonaws.com
Very Important Note: Test this on Bastion Host, as EKS worker nodes doesnt have nslookup tool installed. 
[or]
# Verify clusters.cluster.server value(EKS Cluster API Server Endpoint)   with wget 
Try with wget on Node Group EC2 Instances (both public and private)
wget <Kubernetes API Server Endpoint>
wget https://0cbda14fd801e669f05c2444fb16d1b5.gr7.us-east-1.eks.amazonaws.com

## Sample Output
[ec2-user@ip-10-0-2-205 ~]$ wget https://0cbda14fd801e669f05c2444fb16d1b5.gr7.us-east-1.eks.amazonaws.com
--2021-12-30 08:40:50--  https://0cbda14fd801e669f05c2444fb16d1b5.gr7.us-east-1.eks.amazonaws.com/
Resolving 0cbda14fd801e669f05c2444fb16d1b5.gr7.us-east-1.eks.amazonaws.com (0cbda14fd801e669f05c2444fb16d1b5.gr7.us-east-1.eks.amazonaws.com)... 54.243.111.82, 34.197.138.103
Connecting to 0cbda14fd801e669f05c2444fb16d1b5.gr7.us-east-1.eks.amazonaws.com (0cbda14fd801e669f05c2444fb16d1b5.gr7.us-east-1.eks.amazonaws.com)|54.243.111.82|:443... connected.
ERROR: cannot verify 0cbda14fd801e669f05c2444fb16d1b5.gr7.us-east-1.eks.amazonaws.com's certificate, issued by ‘/CN=kubernetes’:
  Unable to locally verify the issuer's authority.
To connect to 0cbda14fd801e669f05c2444fb16d1b5.gr7.us-east-1.eks.amazonaws.com insecurely, use `--no-check-certificate'.
[ec2-user@ip-10-0-2-205 ~]$


# Verify Pod Infra Container for Kubelete
Example: --pod-infra-container-image=602401143452.dkr.ecr.us-east-1.amazonaws.com/eks/pause:3.1-eksbuild.1
Observation:
1. This Pod Infra container will be downloaded from AWS Elastic Container Registry ECR
2. All the EKS related system pods also will be downloaded from AWS ECR only
```
