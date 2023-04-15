# AWS EC2 Bastion Host
### Types of Provisioner:
1. File Provisioner
2. remote-exec provisioner
3. local-exec provisioner

Notes:
i. Provisioner can be used to model specific actions on the local machine or on a remote machine in order to prepare servers
ii. passing data into virtual machines and other compute resouces.
iii. Running configuration management software (packer, chef, ansible)
iv. Creation-Time Provisioner or Destroy-Time Provisioner
v. Failure Behavior: Continue: Ignore the error and continue with creation or descruction. 
vi. Failure Behavior: Fail: Raise an error and stop applying (the default behavior). if creation provisioner fails, taint resource (for creation or descruction on next)

Connection Block:
Most Provisioners require access to the remote resource via SSH or WinRM, and expect a nested connection block with details about how to connect.

Provisioner
1. File Provisioner:
    i. File Provisioner is used to copy files or directories from the machine executing Terraform to the newly created resource.
    ii. The File Provisioner supports both ssh and winrm type of connections.

2. remote-exec Provisioner:
    i. The remote-exec Provisioner invokes a script on a remote resource after it is created.
    ii. This can be used to run a configuration management tool, bootstrap into a cluster, etc.

3. local-exec Provisioner:
    i. The local-exec Provisioner invokes a local executable after the resource is created.
    ii. This invokes a process on the machine running Terraform, not on the resource.

4. null_resource:
    i. if you need to run provisioners that aren't directly associated with a specific resource, you can associate them with a null_resource.
    ii. Instances of null_resource are treated like normal resources, but they don't do anything.
    iii. Same as other resource, you can configure provisioners and connection details on a null_resource.