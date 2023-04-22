# AWS EKS Resources

### Elastic Network Interfaces (ENI)
i. when you create the cluster, Amazon EKS creates and manages network interfaces in your account that have Amazon EKS <cluster name> in their description.

ii. These network interfaces are allows AWS Fargate and Amazon EC2 instance to communicate with the EKS control plane present in Amazon VPC in Amazon Account (Not our AWS Account).

iii. The Amazon EKS created cluster security group and any additional security groups that you specify when you create your cluster are applied to these network interfaces.

Very Important Note:
These Network Interfaces were created in our EKS VPC in our AWS account but attached to EKS control plan Master Node Instances of Amazon VPC.

