# Nexus

- [Nexus](#nexus)
	- [Description](#description)
		- [Basic Guide - Steps:](#basic-guide---steps)

___
## Description
Nexus is a repository manager that will store “artifacts”, in this case store images. Nexus Provides a centralised location to store data, known as a repository.  
____

### Basic Guide - Steps:
1. Go to AWS Backup > Backup Vaults under My account

2. Go to tools-efs-backup-vault 

3. Under Backups, select the recent recovery point ID, then select Actions, within the dropdown select restore

4. Within the EC2 Services, connect to the tools-nexus-asg via Session Manage

5. Once on the terminal enter the `/efs/aws-backup-restore_xxxx-xx-xxxx-xx-xx-xxxx` directory  


		$ cd /efs
		$ ls
		$ cd aws-backup-restore_2021-08-27T16-38-32-425Z
		$ async -avhP nexus /efs

6. Go back to /efs to check nexus is restored and delete the aws-backup

___

