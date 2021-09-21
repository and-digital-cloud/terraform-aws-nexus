# Nexus

- [Nexus](#nexus)
	- [Description](#description)
	- [Input Variables](#input-variables)
		- [Table Required Variables](#table-required-variables)
		- [Optional Table](#optional-table)
	- [Recovering from a backup](#recovering-from-a-backup)
		- [Basic Guide - Steps:](#basic-guide---steps)

___
## Description
Nexus is a repository manager that will store “artifacts”, in this case store images. Nexus Provides a centralised location to store data, known as a repository.  
____

## Input Variables

All variables in the table below have a defaulted value but can be changed by stating the variable.

### Table Required Variables

| Variable Name    | Default Value             | Description          |
| ---------------- | ------------------------- | -------------------- |
| company_name     | Change this to the client | Name of the company  |
| lb_ingress_rules | null                      | allowed ips to nexus |

It is **essential** to set these variables. `lb_ingress_rules` will throw an error if it is not set. It is recommended to use your own IP with `/32` suffix:

__Example__

lb_ingress_rules = ["255.255.255.255/32"]


### Optional Table 
| Variable Name    | Default Value | Description                                   |
| ---------------- | ------------- | --------------------------------------------- |
| environment      | tools         |                                               |
| service          | nexus         |                                               |
| instance_type    | t3.large      | Instance type for Nexus                       |
| max              | 1             | Maximum number of autoscaling group instances |
| min              | 1             | Minimum number of autoscaling group instances |
| desired_capacity | 1             | Desired Number of autoscaling group instances |
| log_expire_days  | 7             | logs for nexus                                |



__Changing Variable__


Example
 - within the inputs, `instance_type = "t3.medium"` will change the value
____

## Recovering from a backup 


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

