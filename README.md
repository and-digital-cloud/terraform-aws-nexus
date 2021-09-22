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

# terraform-aws-template [![Build Status](https://github.com/and-digital/terraform-aws-template/workflows/build/badge.svg)](https://github.com/and-digital-cloud/terraform-aws-template)

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
  available_zones    = dependency.vpc.outputs.azs
  vpc_id             = dependency.vpc.outputs.vpc_id
  private_subnet_ids = dependency.vpc.outputs.private_subnets
  public_subnet_ids  = dependency.vpc.outputs.public_subnets
  
  # KMS and Route53
  kms_arn            = dependency.global.outputs.kms_key_arn
  acm_wildcard_arn   = dependency.global.outputs.acm_cert_arn
  public_zone_id     = dependency.global.outputs.zone_id

  # Set Inputs
  company_name         = ""
  lb_ingress_rules     = ["255.255.255.255/32"]
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

### Table Required Variables

| Variable Name      | Default Value             | Description                                                 |
| ------------------ | ------------------------- | ----------------------------------------------------------- |
| Set Inputs         | ---------------           | ---------------                                             |
| company_name       | Change this to the client | Name of the company                                         |
| lb_ingress_rules   | null                      | allowed ips to nexus                                        |
| Project_name       | ""                        |                                                             |
|                    |                           |                                                             |
| VPC                | ---------------           | ---------------                                             |
| available_zones    | ""                        |                                                             |
| vpc_id             | ""                        | ID of the VPC                                               |
| private_subnet_ids | ""                        | A list of private subnets inside the VPC                    |
| public_subnet_ids  | ""                        | A list of the subnet subnet inside the VPC                  |
|                    |                           |                                                             |
| Route53 and KMS    | ---------------           | ---------------                                             |
| kms_arn            | "*"                       | The ARN of the KMS Key to use when encrypting SSM for Nexus |
| acm_wildcard_arn   | ""                        | ARN of the certificate                                      |
| public_zone_id     | ""                        | ID of the DNS zone                                          |

It is recommended to use the Terraform `VPC`, `Route53` and `acm` registries for the variables within the VPC respective services.


### Table Optional Variables

| Variable Name          | Default Value   | Description                                                                                  |
| ---------------------- | --------------- | -------------------------------------------------------------------------------------------- |
| telegraf               | --------------- | ---------------                                                                              |
| install_telegraf       | false           | Installing telegraf                                                                          |
| metric_user            | null            | Nexus username for the metrics user                                                          |
| metric_password        | null            | metrics user password to scrape metrics from prometheus endpoint                             |
| influxdb_database      | null            | Destination database on the influxdb instance                                                |
| influxdb_endpoint      | null            | Hostname & port of the influxdb server or load balancer in this format http://example.com:80 |
|                        |                 |                                                                                              |
| load balancer          | --------------- | ---------------                                                                              |
| listener_arn           | ""              | ARN of the listener                                                                          |
| # create_load_balancer | false           | Set to true when you have your own load balancer and import the listener_arn                 |
|                        |                 |



<!--- BEGIN_TF_DOCS --->
## Providers

## Inputs

## Outputs

<!--- END_TF_DOCS --->

## License

Apache 2 Licensed. See [HERE](https://github.com/and-digital-cloud/terraform-aws-nexus/blob/master/LICENSE) for full details.