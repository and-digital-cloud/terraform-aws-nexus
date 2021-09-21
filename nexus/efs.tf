resource "aws_efs_file_system" "efs_nexus" {
  creation_token = "${var.environment}-${var.service}-token"
  encrypted      = true
  tags = {
    Name        = "${var.service}"
    Type        = "EFS"
    Environment = var.environment
    Service     = var.service
  }
}
resource "aws_efs_mount_target" "efs_mount" {
  count           = length(var.private_subnet_ids)
  file_system_id  = aws_efs_file_system.efs_nexus.id
  subnet_id       = element(var.private_subnet_ids, count.index)
  security_groups = [aws_security_group.efs_security_group.id]
}

