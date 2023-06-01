DevOps Toolchain Factory
==========================

Ce projet contient les rôles et playbooks Ansible pour créer (provisioning) et configurer une Toolchain DevOps sur AWS. Cette Toolchain DevOps comprends les systèmes suivants : FreeIPA, Jenkins (un maître et des agents), GitLab, Nexus et Hashicorp Vault.

**Note**: 
Les playbooks et les rôles Ansible nécessitent un environnement Ansible configuré dans lequel les nœuds Ansible sont accessibles et correctement configurés pour avoir une adresse IP et un gestionnaire de packages de travail.

Features
--------
* Provisioning d'une intance EC2 contenant FreeIPA
* Provisioning d'une intance EC2 contenant Jenkins
* Provisioning d'une N intance(s) EC2 contenant Des outils de contruction; N est un paramètre.
* Provisioning d'une intance EC2 contenant Hashicorp Vault
* Provisioning d'une intance EC2 contenant GitLab-CE
* Provisioning d'une intance EC2 contenant Nexus OSS
* Configuration de FreeIPA (LDAP, Kerberos, DNS, PKI, NTP, SSSD)
* Configuration des clients de FreeIPA (cluster Jenkins, GitLab, Nexus, Hashicorp Vault)
* Configuration du cluster Jenkins
* Configuration de Hashicorp Vault
* Configuration de GitLab
* Configuration de Nexus

Supported Versions
--------------------------

FreeIPA Serveur XXX
FreeIPA Client XXX 
Jenkins XXX
GitLab-CE XXX
Nexus OSS 3.47.1-01
Hashicorp Vault XXX

Supported Distributions
-----------------------

* RHEL/CentOS 8+

Requirements
------------

**Controleur Ansible**
* Ansible version: 2.11.12+
* Ansible Module Hashivault: 5.0.0 (à installer sur le NUC via la commande `pip3 install --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org --proxy http://172.16.40.4:8080 --default-timeout=100 ansible-modules-hashivault`)
* Terraform version: 1.3.8+
* OpenSSH version: 7.6+

Limitations
-----------

**Sécurisation des échanges**

Pour des raisons de simplicité et de vélocité, les échanges entre les différents noeuds de la toolchain se font aujourd'hui en http. 

Il prévu de passer en https dans le futur.


Usage
=====

Comment utiliser la Toolchain Factory
--------------------------

**Prépration au déploiement**

La méthode la plus simple est de cloner depuis le *NUC* le dépôt GitLab et de commencer le déploiement dépuis le dossier `devops-toolchain-factory` :

```bash
git clone https://gitlab.znp.zac.stet/devops-factory/devops-toolchain-factory.git
cd devops-toolchain-factory
```
Ensuite mofier le fichier `init_env.sh` qui sert à lancer un environnement virtuel Python et à charger dans un agent ssh les clés privés utilsées par Ansible. Voic le contenu de ce fichier : 
```bash
source $HOME/env/bin/activate
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/sabr.private
ssh-add -L
```
Supprimer la première ligne si vous n'utilisez pas d'environnement virtuel Python. Ensuite remplacer `id_rsa` par votre clé privé et assurez-vous que la clé `sabr.private` se trouve dans votre dossier `~/.ssh`. Ces deux clés sont utilisées par Ansible pour se connecter sur les différentes instances EC2.

Exécuter ensuite le fichier `init_env.sh`:
```bash
source init_env.sh
```
Editez ensuite le fichier `ansible/ansible.cfg` et remplacer `/home/snangue` par votre `$HOME` :  
```bash
[defaults]
roles_path = roles
localhost_warning = False
deprecation_warnings = False
inventory = inventory/hosts
host_key_checking = False

[ssh_connection]
ssh_args = -F /home/snangue/.ssh/config -o ControlMaster=auto -o ControlPersist=30m -o ForwardAgent=yes
control_path = /tmp/ansible-%%r@%%h:%%p
```
Enfin ensuite editer les fichiers `ansible/vars/secrets.yml` et `ansible/vars/variables.yml`, remplacer les valeurs par celles qui vous conviennent et `/home/snangue` par votre `$HOME`. 

**Déploiement proprement dit**

Utiliser le bout de code ci-dessous pour créer une instance de la Toolchain DevOps sur AWS :
```bash
cd ansible
ansible-playbook playbooks/toolchain.yml --tags "provision"
```
Une fois la création de l'instance terminée, utiliser le bout de code ci-dessous pour configurer la Toolchain DevOps :
```bash
cd ansible
ansible-playbook playbooks/toolchain.yml --tags "configure"
```
Utiliser le bout de code ci-dessous pour détruire l'instance de la Toolchain DevOps :
```bash
cd ansible
ansible-playbook playbooks/toolchain.yml --tags "destroy"
```

Inventory Ansible
=================

**Serveur FreeIPA**

**Clients FreeIPA**

**Master Jenkins**

**Workers Jenkins**

**Hashicorp Vault**

**Nexus OSS**

**GitLab CE**


Playbooks
=========


Roles
=====
