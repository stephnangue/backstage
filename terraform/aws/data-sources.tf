data "aws_ami" "jenkins-master" {
    most_recent = true
    owners = [ "self" ]

    filter {
      name = "tag:Name"
      values = [ "jenkins-master-*" ]
    }
}

data "aws_ami" "jenkins-generic-worker" {
    most_recent = true
    owners = [ "self" ]

    filter {
      name = "tag:Name"
      values = [ "jenkins-generic-worker-*" ]
    }
}

data "aws_ami" "hashicorp-vault" {
    most_recent = true
    owners = [ "self" ]

    filter {
      name = "tag:Name"
      values = [ "hashicorp-vault-*" ]
    }
}

data "aws_ami" "nexus-repository" {
    most_recent = true
    owners = [ "self" ]

    filter {
      name = "tag:Name"
      values = [ "nexus-repository-*" ]
    }
}

data "aws_ami" "gitlab-server" {
    most_recent = true
    owners = [ "self" ]

    filter {
      name = "tag:Name"
      values = [ "gitlab-server-*" ]
    }
}

data "aws_ami" "freeipa-server" {
    most_recent = true
    owners = [ "self" ]

    filter {
      name = "tag:Name"
      values = [ "freeipa-server-*" ]
    }
}

data "aws_ami" "backstage" {
    most_recent = true
    owners = [ "self" ]

    filter {
      name = "tag:Name"
      values = [ "backstage-*" ]
    }
}

data "aws_vpc" "devops-lab-vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
} 

data "aws_security_group" "devops-lab-security-group" {
  name = var.default_security_group
  vpc_id = data.aws_vpc.devops-lab-vpc.id
}

data "aws_subnet" "devops-lab-private-subnet" {
  availability_zone = var.availability_zone
  vpc_id = data.aws_vpc.devops-lab-vpc.id
}

data "aws_iam_instance_profile" "devops-lab-instance-profile" {
  name = var.iam_instance_profile
}

data "aws_iam_user" "iam_user" {
  user_name = var.aws_iam_username
}
