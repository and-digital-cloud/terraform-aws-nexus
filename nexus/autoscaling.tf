# Autoscaling Group
resource "aws_autoscaling_group" "dev_nexus" {
  name                      = "${var.environment}-${var.service}-asg"
  max_size                  = var.max
  min_size                  = var.min
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300
  health_check_type         = "EC2"

  # EC2 instead of ELB, now load balancer only serves when ec2 is healthy
  force_delete         = true
  launch_configuration = aws_launch_configuration.dev_nexus.name
  vpc_zone_identifier  = var.private_subnet_ids
  target_group_arns    = [aws_lb_target_group.nexus_blue.arn]
  lifecycle {
    create_before_destroy = true
  }
  tags = [
    {
      "key"                 = "owner"
      "value"               = "AND"
      "propagate_at_launch" = true
    },
    {
      "key"                 = "project"
      "value"               = "${var.project_name}"
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Name"
      "value"               = "${var.environment}-${var.service}-asg"
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Service"
      "value"               = "${var.service}"
      "propagate_at_launch" = true
    },
    {
      "key"               = "Environment",
      "value"             = var.environment
      propagate_at_launch = true
    }
  ]
}


# Launch Configuration
resource "aws_launch_configuration" "dev_nexus" {
  name_prefix          = "${var.environment}-${var.service}-web-config"
  image_id             = data.aws_ami.nexus.id
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.nexus_security_group.id]
  iam_instance_profile = aws_iam_instance_profile.instance_profile.id
  enable_monitoring    = true
  user_data            = templatefile("${path.module}/lib/nexus.sh.tpl",
    {
      efs_mount         = aws_efs_file_system.efs_nexus.dns_name
      service_name      = var.service
      environment       = var.environment
      aws_account_name  = data.aws_iam_account_alias.current.account_alias
      install_telegraf  = var.install_telegraf
      metrics_user      = var.metrics_user
      metrics_password  = var.metrics_password
      influxdb_database = var.influxdb_database
      influxdb_endpoint = var.influxdb_endpoint
  })
  root_block_device {
    encrypted = true
  }
  lifecycle {
    create_before_destroy = true
  }
}

