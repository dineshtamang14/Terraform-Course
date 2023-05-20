- Create Dynamo DB Table for EKS IRSA Demo
  - **Table Name:** dev-eks-irsa-demo
  - **Partition key (Primary Key):** LockID (Type as String)
  - **Table settings:** Use default settings (checked)
  - Click on **Create**


### To list the Service Account
```kubectl get sa```
```kubectl describe sa irsa-demo```

### List and Describe kubernetes Jobs
```kubectl get job```
```kubectl describe job irsa-demo```

### Verify Logs (by giving job label app=irsa-demo)
```kubectl logs -f -l app=irsa-demo```    # here -l is label flag


### To List a create Resources
```terraform state list```

### To Taint a Resources (deprecated)
```terraform taint kubernetes_job_v1.irsa_demo```
```terraform apply```

### new command for above one
```terraform apply -replace kubernetes_job_v1.irsa_demo```

### To Delete a job
```kubectl delete job irsa-demo```
