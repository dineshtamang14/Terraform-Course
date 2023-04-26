### To create EFS filesystem
aws efs create-file-system --creation-token 1

### To check subnet id of nodes
aws ec2 describe-instances

### To create EFS Mount Target 
aws efs create-mount-target --file-system-id fs-571e89e --subnet-id subnet-8cc390 --security-groups sg-f1a22797 

