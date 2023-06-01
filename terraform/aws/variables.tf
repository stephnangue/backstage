variable "aws_iam_username" {
    type = string
    description = "AWS IAM username"   
}

variable "region" {
    type = string
    description = "AWS region"
}

variable "vpc_name" {
    type = string
    description = "VPC name"   
}

variable "author" {
    type = string
    description = "Created by"   
}

variable "shared_credentials_file" {
    type = string
    description = "VPC name"   
} 

variable "availability_zone" {
    type = string
    description = "Availability zone"   
}

variable "key_pair" {
    type = string
    description = "Key pair name"  
    default = "sabr-devops-lab-key"
}

variable "jenkins_master_instance_type" {
    type = string
    description = "Jenkins Master EC2 instance type" 
    default = "t2.medium" 
}

variable "jenkins_worker_instance_type" {
    type = string
    description = "Jenkins Worker EC2 instance type" 
    default = "t2.medium" 
}

variable "hashicorp_vault_instance_type" {
    type = string
    description = "Hashicorp Vault EC2 instance type" 
    default = "t2.medium" 
}

variable "nexus_repository_instance_type" {
    type = string
    description = "Nexus Repository EC2 instance type" 
    default = "t2.medium" 
}

variable "gitlab_server_instance_type" {
    type = string
    description = "Gitlab Server EC2 instance type" 
    default = "t2.medium" 
}

variable "freeipa_server_instance_type" {
    type = string
    description = "FreeIPA Server EC2 instance type" 
    default = "t2.medium" 
}

variable "backstage_instance_type" {
    type = string
    description = "Backstage EC2 instance type" 
    default = "t2.medium" 
}

variable "default_security_group" {
    type = string
    description = "Default security group" 
    default = "default" 
}

variable "iam_instance_profile" {
    type = string
    description = "IAM Instance profile" 
    default = "sabr_devops_lab_instance_profile" 
}

variable "jenkins_credential_id" {
    type = string
    description = "jenkins worker SSH based credential id"
    default = "jenkins-worker-key-id"   
}

variable "number_of_jenkins_generic_worker" {
    type = number
    description = "How many jenkins generic workers"
    default = 1  
}

variable "inventory_path" {
    type = string
    description = "Where the generated inventory will be stored" 
}

variable "domain_name" {
    type = string
    description = "Domain that will be used to construct hostnames" 
}