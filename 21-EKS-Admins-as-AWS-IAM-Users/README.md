## Access EKS Cluster with hr-dev-eksadmin1 user (AWS IAM Admin User)
### Set Credentials for hr-dev-eksadmin1 user
```t
# Set password for hr-dev-eksadmin1 user
aws iam create-login-profile --user-name hr-dev-eksadmin1 --password @EKSUser101 --no-password-reset-required

# Create Security Credentials for IAM User and make a note of them
aws iam create-access-key --user-name hr-dev-eksadmin1

# Make a note of Access Key ID and Secret Access Key
User: hr-dev-eksadmin1
{
    "AccessKey": {
        "UserName": "hr-dev-eksadmin1",
        "AccessKeyId": "AKIASUF7HC7S4XG3ZL3W",
        "Status": "Active",
        "SecretAccessKey": "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",
        "CreateDate": "2022-03-12T04:21:33+00:00"
    }
}
```
### Access EKS  Service using AWS Mgmt Console
- Login and access EKS Service using AWS Mgmt Console
  - **Username:** hr-dev-eksadmin1
  - **Password:** @EKSUser101
- Go to  Services -> Elastic Kubernetes Service -> hr-dev-eksdemo1
  - Overview Tab
  - Workloads Tab
  - Configuration Tab


### Step-08-03: Configure hr-dev-eksadmin1 user AWS CLI Profile
```t
# To list all configuration data
aws configure list

# To list all your profile names
aws configure list-profiles

# Configure aws cli hr-dev-eksadmin1 Profile 
aws configure --profile hr-dev-eksadmin1
AWS Access Key ID: AKIASUF7HC7S4XG3ZL3W
AWS Secret Access Key: 2Qu53xZVjazSnDTTp5PH1PswbUKff0SByaNa53qE
Default region: us-east-1
Default output format: json

# To list all your profile names
aws configure list-profiles
```  

### Access EKS Resources using kubectl
```t
# Clean-Up kubeconfig
>$HOME/.kube/config
cat $HOME/.kube/config

# Configure kubeconfig for kubectl with AWS CLI Profile hr-dev-eksadmin1
aws eks --region <region-code> update-kubeconfig --name <cluster_name> --profile <AWS-CLI-PROFILE-NAME>
aws eks --region us-east-1 update-kubeconfig --name hr-dev-eksdemo1 --profile hr-dev-eksadmin1
Observation:
1. It should pass

# Verify kubeconfig 
cat $HOME/.kube/config
      env:
      - name: AWS_PROFILE
        value: hr-dev-eksadmin1
Observation: At the end of kubeconfig file we find that AWS_PROFILE it is using is "hr-dev-eksadmin1" profile   


# List Kubernetes Nodes
kubectl get nodes

# Review aws-auth configmap
kubectl -n kube-system get configmap aws-auth -o yaml
Observation:
1. We should see both users in mapUsers section
```

## Access EKS Cluster with hr-dev-eksadmin2 user (AWS Basic User)
### Set Credentials for hr-dev-eksadmin2 user
```t
# Set password for hr-dev-eksadmin2 user
aws iam create-login-profile --user-name hr-dev-eksadmin2 --password @EKSUser101 --no-password-reset-required

# Create Security Credentials for IAM User and make a note of them
aws iam create-access-key --user-name hr-dev-eksadmin2

# Make a note of Access Key ID and Secret Access Key
User: hr-dev-eksadmin1
{
    "AccessKey": {
        "UserName": "hr-dev-eksadmin2",
        "AccessKeyId": "AKIASUF7HC7SRVES7ADE",
        "Status": "Active",
        "SecretAccessKey": "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",
        "CreateDate": "2022-03-12T04:27:46+00:00"
    }
}
```
### Access EKS  Service using AWS Mgmt Console
- Login and access EKS Service using AWS Mgmt Console
  - **Username:** hr-dev-eksadmin2
  - **Password:** @EKSUser101
- Go to  Services -> Elastic Kubernetes Service -> hr-dev-eksdemo1
  - Overview Tab
  - Workloads Tab
  - Configuration Tab

### Configure hr-dev-eksadmin2 user AWS CLI Profile 
```t
# To list all configuration data
aws configure list

# To list all your profile names
aws configure list-profiles

# Configure aws cli hr-dev-eksadmin1 Profile 
aws configure --profile hr-dev-eksadmin2
AWS Access Key ID: AKIASUF7HC7SRVES7ADE
AWS Secret Access Key: sASjutJvDS9GS0R7MFBMXr/F05fFV53kMpVnlyQ5
Default region: us-east-1
Default output format: json

# To list all your profile names
aws configure list-profiles
```  

### Step-09-04: Access EKS Resources using kubectl
```t
# Clean-Up kubeconfig
>$HOME/.kube/config
cat $HOME/.kube/config

# Configure kubeconfig for kubectl with AWS CLI Profile hr-dev-eksadmin1
aws eks --region <region-code> update-kubeconfig --name <cluster_name> --profile <AWS-CLI-PROFILE-NAME>
aws eks --region us-east-1 update-kubeconfig --name hr-dev-eksdemo1 --profile hr-dev-eksadmin2
Observation:
1. It should pass

# Verify kubeconfig 
cat $HOME/.kube/config
      env:
      - name: AWS_PROFILE
        value: hr-dev-eksadmin2
Observation: At the end of kubeconfig file we find that AWS_PROFILE it is using is "hr-dev-eksadmin2" profile  

# List Kubernetes Nodes
kubectl get nodes

# Review aws-auth configmap
kubectl -n kube-system get configmap aws-auth -o yaml
Observation:
1. We should see both users in mapUsers section
```

## Clean-Up EKS Cluster
- As the other two users also can delete the EKS Cluster, then why we are going for Cluster Creator user ?
- Those two users we created are using Terraform, so if we use those users with terraform destroy, in the middle of destroy process those users will ge destroyed.
- EKS Cluster Creator user is already pre-created and not terraform managed. 
```t
# Get current user configured in AWS CLI
aws sts get-caller-identity
Observation: Should see the user "dineshtamang14" (EKS_Cluster_Create_User) from default profile

# Destroy EKS Cluster
terraform apply -destroy -auto-approve
rm -rf .terraform*
```

## clean-up AWS CLI Profiles
```t
# Clean-up AWS Credentials File
vim .aws/credentials
Remove hr-dev-eksadmin1 and hr-dev-eksadmin2 creds

# Clean-Up AWS Config File
vim .aws/config 
Remove hr-dev-eksadmin1 and hr-dev-eksadmin2 profiles

# List Profiles - AWS CLI
aws configure list-profiles
```

## Additional References
- [Enabling IAM user and role access to your cluster](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html)
- [AWS CLI Profiles](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
- [EKS Cluster Access](https://aws.amazon.com/premiumsupport/knowledge-center/amazon-eks-cluster-access/)