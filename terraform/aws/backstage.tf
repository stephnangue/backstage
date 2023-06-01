resource "aws_instance" "backstage" {
    ami = data.aws_ami.backstage.id
    instance_type = var.backstage_instance_type

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
      Name = "devops-lab@${data.aws_iam_user.iam_user.user_name}-backstage"
      Author = var.author
      ded_rp_https = "no"
      ded_rp_https-1 = "no"
      ded_rp_dnsname = "backstage"
      ded_rp_project = "devopslab"
      ded_rp_port = "3000"
      ansible_group = "backstage"
      project = "sabr_devops_lab"
    }

} 

resource "aws_ec2_tag" "backstage_backend_tag" {
  resource_id = aws_instance.backstage.id
  key = "ded_rp_target-1"
  value = "${aws_instance.backstage.private_ip}:7007"
}