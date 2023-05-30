# Packer commands
### initializing the packer
```sh
packer init .
```

### To format the source code
```sh
packer fmt .
```

### To validate the configuration
```sh
packer validate .
```

### To build a image
```sh
packer build aws-ubuntu.pkr.hcl
```

### Passing variables value during a build
```sh
packer build -var 'project=webserver' -var 'version=1.0.1' aws-ubuntu.pkr.hcl
```

### Passing a variable file
```sh
packer build -var-file=var.pkr.hcl aws-ubuntu.pkr.hcl
```
