output "dns_name" {
  value = aws_lb.load_balancer.*.dns_name
}

output "asg_arn" {
  value = aws_autoscaling_group.dev_nexus.arn
}

output "efs_arn" {
  value = aws_efs_file_system.efs_nexus.arn
}
