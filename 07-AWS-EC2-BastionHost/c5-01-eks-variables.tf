# EKS Cluster Input Variables
variable "cluster_name" {
    description = "Name of the EKS cluster. Also used as Prefix in names of related resources."
    type = string 
    default = "eksdemo"
}