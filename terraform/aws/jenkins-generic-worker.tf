resource "aws_instance" "jenkins-generic-worker" {

    count = var.number_of_jenkins_generic_worker

    ami = data.aws_ami.jenkins-generic-worker.id
    instance_type = var.jenkins_worker_instance_type

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
      Name = "devops-lab@${data.aws_iam_user.iam_user.user_name}-jenkins-generic-worker-${count.index}"
      Author = var.author
      ansible_group = "worker"
      project = "sabr_devops_lab"
    }

} 