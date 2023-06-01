resource "aws_instance" "hashicorp-vault" {
    ami = data.aws_ami.hashicorp-vault.id
    instance_type = var.hashicorp_vault_instance_type

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
      Name = "devops-lab@${data.aws_iam_user.iam_user.user_name}-hashicorp-vault"
      Author = var.author
      ded_rp_https = "no"
      ded_rp_dnsname = "vault"
      ded_rp_project = "devopslab"
      ded_rp_port = "8200"
      ansible_group = "vault"
      project = "sabr_devops_lab"
    }

} 