This is a template repo, you will need to update:

- [x] Update links in the contributing.md
- [x] Links in the readme.md
- [x] Headings in the readme.md
- [x] The readme.md content
- [x] Link at the top of .releaserc
- [ ] Add at least a completed example in the examples folder

Notes:
- Pipeline should just work out of the box when .releaserc is updated
- Terraform docs will populate the inputs and outputs during pipeline run 
- Delete these sections when finished 

# terraform-aws-template [![Build Status](https://github.com/and-digital/terraform-aws-template/workflows/build/badge.svg)](https://github.com/and-digital-cloud/terraform-aws-template/actions)

> A terraform module for creating AWS template resources.

## Table of Contents

- [Maintenance](#maintenance)
- [Getting Started](#getting-started)
- [License](#license)

## Maintenance

This project is maintained [AND Digital](https://github.com/and-digital-cloud), anyone is welcome to contribute.

## Getting Started

#### Example


```
module "nexus" {
  source = "../../"

   # VPC
  available_zones    = ["eu-west-1a", "eu-west-1b"]
  vpc_id             = "vpc-0b234848bfhh83011"
  private_subnet_ids = ["subnet-0d533ecad433dacfc", "]
  public_subnet_ids  = ["subnet-0e0d79f24c091kda2", "subnet-051486alp823y9118"]
  
  # KMS and Route53
  kms_arn            = "arn:aws:kms:eu-west-1:760724145001:key/2b832473-123g-456l-567j-73fc7sdf5eec"
  acm_wildcard_arn   = "arn:aws:acm:eu-west-1:760724145001:certificate/96r46b8e-69a2-476bc-98-yaya801190e3"
  public_zone_id     = "Z02933551428GK93MXLE6"

  # Set Inputs
  company_name         = ""
  lb_ingress_rules     = ["255.255.255.255/32"] # your ip ending /32 suffix
  project_name         = "" 

  # Telegraf
  install_telegraf  = false
  metrics_user      = "metrics"
  metrics_password  = ""
  influxdb_database = "telegraf"
  influxdb_endpoint = ""

  # Listener (optional)
  # create_load_balancer = false
  # listener_arn         = ""

  an example

```


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.dev_nexus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_efs_file_system.efs_nexus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.efs_mount](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_iam_instance_profile.instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.kms_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.nexus_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ssm_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.kms_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.nexus_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ssm_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_configuration.dev_nexus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_lb.load_balancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.nexus_forwarder_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.nexus_blue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_route53_record.nexus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.log_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.nexus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.access_log_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.nexus_log_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_security_group.efs_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.load_balancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.nexus_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_nfs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.efs_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.efs_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.lb_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.lb_nexus_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nexus_egress_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nexus_port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.nexus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_iam_account_alias.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_account_alias) | data source |
| [aws_iam_policy_document.ec2_role_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.kms_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.nexus_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_wildcard_arn"></a> [acm\_wildcard\_arn](#input\_acm\_wildcard\_arn) | n/a | `string` | `""` | no |
| <a name="input_available_zones"></a> [available\_zones](#input\_available\_zones) | n/a | `list(string)` | n/a | yes |
| <a name="input_company_name"></a> [company\_name](#input\_company\_name) | Name of the company | `string` | `"Change this to the client"` | no |
| <a name="input_create_load_balancer"></a> [create\_load\_balancer](#input\_create\_load\_balancer) | whether to create resource | `bool` | `true` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Desired number of Autoscaling Groups | `number` | `1` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | `"tools"` | no |
| <a name="input_influxdb_database"></a> [influxdb\_database](#input\_influxdb\_database) | Destination database on the influxdb instance | `string` | `"telegraf"` | no |
| <a name="input_influxdb_endpoint"></a> [influxdb\_endpoint](#input\_influxdb\_endpoint) | Hostname & port of the influxdb server or load balancer in this format http://example.com:80 | `string` | `null` | no |
| <a name="input_install_telegraf"></a> [install\_telegraf](#input\_install\_telegraf) | Defaults to false. Install the telegraf agent, requires passing the endpoint and username/password for metrics within nexus. This will not be possible till you login and configure the user the first time | `bool` | `false` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | type of instance | `string` | `"t3.large"` | no |
| <a name="input_kms_arn"></a> [kms\_arn](#input\_kms\_arn) | ARN of KMS key used by cloudwatch used in session manager | `string` | `"*"` | no |
| <a name="input_lb_ingress_rules"></a> [lb\_ingress\_rules](#input\_lb\_ingress\_rules) | allowed ips to nexus | `list(string)` | <pre>[<br>  "null"<br>]</pre> | no |
| <a name="input_listener_arn"></a> [listener\_arn](#input\_listener\_arn) | Listener arn | `string` | `""` | no |
| <a name="input_log_expire_days"></a> [log\_expire\_days](#input\_log\_expire\_days) | value | `number` | `7` | no |
| <a name="input_max"></a> [max](#input\_max) | Maximum number of autoscaling group instances | `number` | `1` | no |
| <a name="input_metrics_password"></a> [metrics\_password](#input\_metrics\_password) | metrics user password to scrape metrics from prometheus endpoint | `string` | `null` | no |
| <a name="input_metrics_user"></a> [metrics\_user](#input\_metrics\_user) | Nexus username for the metrics user | `string` | `null` | no |
| <a name="input_min"></a> [min](#input\_min) | Minimum number of autoscaling groups instances | `number` | `1` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | ID of the private subnet | `list(string)` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | `""` | no |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | ID of the subnet subnet | `list(string)` | n/a | yes |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | n/a | `string` | `""` | no |
| <a name="input_service"></a> [service](#input\_service) | Service name | `string` | `"nexus"` | no |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | n/a | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_asg_arn"></a> [asg\_arn](#output\_asg\_arn) | n/a |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | n/a |
| <a name="output_efs_arn"></a> [efs\_arn](#output\_efs\_arn) | n/a |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. See [HERE](https://github.com/and-digital-cloud/terraform-aws-nexus/blob/master/LICENSE) for full details.