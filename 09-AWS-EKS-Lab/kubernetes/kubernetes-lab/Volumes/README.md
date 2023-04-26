### To create a EBS Volume
aws ec2 create-volume --size 10 --region us-east-1 --availability-zone us-east-1a --volume-type gp2

### To Drain a Node
kubectl drain node-label-or-name

### To delete EBS Volume
aws ec2 delete-volume --volume-id vol-083748ee

