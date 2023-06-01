terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = "1.3.7"
}

provider "aws" {
  region = var.region
  shared_credentials_files =[var.shared_credentials_file] 
}