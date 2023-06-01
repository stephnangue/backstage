resource "aws_instance" "nexus-repository" {
    ami = data.aws_ami.nexus-repository.id
    instance_type = var.nexus_repository_instance_type

    key_name = var.key_pair
    vpc_security_group_ids = [data.aws_security_group.devops-lab-security-group.id]
    subnet_id = data.aws_subnet.devops-lab-private-subnet.id
    iam_instance_profile = data.aws_iam_instance_profile.devops-lab-instance-profile.name

    root_block_device {
      volume_type = "gp2"
      volume_size = 128
      delete_on_termination = true
    }

    tags = {
      Name = "devops-lab@${data.aws_iam_user.iam_user.user_name}-nexus-repository"
      Author = var.author
      ded_rp_https = "no"
      ded_rp_dnsname = "nexus"
      ded_rp_project = "devopslab"
      ded_rp_port = "8081"
      ansible_group = "nexus"
      project = "sabr_devops_lab"
    }

} 