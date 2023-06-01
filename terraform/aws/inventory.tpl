[jenkins_master]
%{ for index, group in ansible_group_jenkins ~}
jksmaster.${lab_domain_name} ansible_host=${ip_address_jenkins[index]}
%{ endfor ~}

[jenkins_workers]
%{ for index, group in ansible_group_jenkins_worker ~}
jksworker${index}.${lab_domain_name} ansible_host=${ip_address_jenkins_worker[index]}
%{ endfor ~}

[vault]
%{ for index, group in ansible_group_vault ~}
vault.${lab_domain_name} ansible_host=${ip_address_vault[index]}
%{ endfor ~}

[nexus]
%{ for index, group in ansible_group_nexus ~}
nexus.${lab_domain_name} ansible_host=${ip_address_nexus[index]}
%{ endfor ~}

[gitlab]
%{ for index, group in ansible_group_gitlab ~}
gitlab.${lab_domain_name} ansible_host=${ip_address_gitlab[index]}
%{ endfor ~}

[ipaserver]
%{ for index, group in ansible_group_freeipa ~}
ipaserver.${lab_domain_name} ansible_host=${ip_address_freeipa[index]}
%{ endfor ~}

[backstage]
%{ for index, group in ansible_group_backstage ~}
backstage.${lab_domain_name} ansible_host=${ip_address_backstage[index]}
%{ endfor ~}

[ipaclients:children]
jenkins_master
jenkins_workers
vault
nexus
gitlab
backstage
