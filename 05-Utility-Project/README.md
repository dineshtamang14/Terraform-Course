### Command to check instance type support in per az's
```sh
aws ec2 describe-instance-type-offerings --location-type availability-zone --fileters Name=instance-type,Values=t3.micro --region us-east-1 output table
```
