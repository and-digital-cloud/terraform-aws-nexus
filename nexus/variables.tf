variable "environment" {
  default     = "tools"
  type        = string
  description = "Environment name"
}

variable "service" {
  default     = "nexus"
  type        = string
  description = "Service name"
}

variable "instance_type" {
  default     = "t3.large"
  type        = string
  description = "type of instance"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "ID of the private subnet"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "ID of the subnet subnet"
}

variable "max" {
  default     = 1
  type        = number
  description = "Maximum number of autoscaling group instances"
}

variable "min" {
  default     = 1
  type        = number
  description = "Minimum number of autoscaling groups instances"
}

variable "desired_capacity" {
  default     = 1
  type        = number
  description = "Desired number of Autoscaling Groups"
}

variable "log_expire_days" {
  default     = 7
  type        = number
  description = "value"
}

variable "kms_arn" {
  default     = "*"
  type        = string
  description = "ARN of KMS key used by cloudwatch used in session manager"
}


variable "available_zones" {
  type = list(string)
}

variable "acm_wildcard_arn" {
  type        = string
  description = ""
  default     = ""
}

variable "public_zone_id" {
  type        = string
  description = ""
  default     = ""
}

variable "company_name" {
  default     = "Change this to the client"
  type        = string
  description = "Name of the company"
}

variable "lb_ingress_rules" {
  default     = ["null"]
  type        = list(string)
  description = "allowed ips to nexus"
}

variable "create_load_balancer" {
  default = true
  type    = bool
  description = "whether to create resource"
}

variable "target_group_arns" {
  type        = list(string)
  default     = []
}

variable "project_name" {
  type    = string
  default = "" 
}

variable "install_telegraf" {
  type = bool
  default = false
  description = "Defaults to false. Install the telegraf agent, requires passing the endpoint and username/password for metrics within nexus. This will not be possible till you login and configure the user the first time"
}

variable "metrics_user" {
  type = string
  default = null
  description = "Nexus username for the metrics user"
}

variable "metrics_password" {
  type = string
  default = null
  description = "metrics user password to scrape metrics from prometheus endpoint"
}

variable "influxdb_database" {
  type = string
  default = "telegraf"
  description = "Destination database on the influxdb instance"
}

variable "influxdb_endpoint" {
  type = string
  default = null
  description = "Hostname & port of the influxdb server or load balancer in this format http://example.com:80"
}

variable "listener_arn" {
  type        = string
  default     = ""
  description = "Listener arn"
  
}