resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tpl",
   {
     ansible_group_jenkins = aws_instance.jenkins-master.*.tags.ansible_group,
     ip_address_jenkins = aws_instance.jenkins-master.*.private_ip,
     ansible_group_jenkins_worker = aws_instance.jenkins-generic-worker.*.tags.ansible_group,
     ip_address_jenkins_worker = aws_instance.jenkins-generic-worker.*.private_ip,
     ansible_group_vault = aws_instance.hashicorp-vault.*.tags.ansible_group,
     ip_address_vault = aws_instance.hashicorp-vault.*.private_ip,
     ansible_group_nexus = aws_instance.nexus-repository.*.tags.ansible_group,
     ip_address_nexus = aws_instance.nexus-repository.*.private_ip,
     ansible_group_gitlab = aws_instance.gitlab-server.*.tags.ansible_group,
     ip_address_gitlab = aws_instance.gitlab-server.*.private_ip,
     ansible_group_backstage = aws_instance.backstage.*.tags.ansible_group,
     ip_address_backstage = aws_instance.backstage.*.private_ip,
     ansible_group_freeipa = aws_instance.freeipa-server.*.tags.ansible_group,
     ip_address_freeipa = aws_instance.freeipa-server.*.private_ip,
     lab_domain_name = var.domain_name
   } 
  )
  filename = "${var.inventory_path}/hosts"
}