resource "aws_instance" "jenkins-master" {
    ami = data.aws_ami.jenkins-master.id
    instance_type = var.jenkins_master_instance_type

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
      Name = "devops-lab@${data.aws_iam_user.iam_user.user_name}-jenkins-master"
      Author = var.author
      ded_rp_https = "no"
      ded_rp_dnsname = "jksmaster"
      ded_rp_project = "devopslab"
      ded_rp_port = "8080"
      ansible_group = "jenkins"
      project = "sabr_devops_lab"
    }

} 