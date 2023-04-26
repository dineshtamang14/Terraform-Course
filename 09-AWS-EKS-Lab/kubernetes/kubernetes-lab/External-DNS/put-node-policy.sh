#!/bin/bash

# This script addes permissions to the nodes IAM Role, enabling any pod to use
# AWS privileges usage of kube2iam is recommended, but not yet implemented by default in kops

DEFAULT_REGION="us-east-1"
AWS_REGION="${AWS_REGION:-${DEFAULT_REGION}}"

NODE_ROLE="HR-stag-eks-nodegroup-role"

export AWS_REGION

aws iam put-role-policy --role-name ${NODE_ROLE} --policy-name external-dns-policy --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": [
                "arn:aws:route53:::hostedzone/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:ListHostedZones",
                "route53:ListResourceRecordSets"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}'