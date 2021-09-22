resource "aws_security_group" "nexus_security_group" {
  name   = "${var.environment}-${var.service}-instance-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "efs_security_group" {
  name   = "${var.environment}-${var.service}-efs-sg"
  vpc_id = var.vpc_id

  depends_on = [aws_efs_file_system.efs_nexus]
}

resource "aws_security_group" "load_balancer" {
  name   = "${var.environment}-${var.service}-loadbalancer-sg"
  vpc_id = var.vpc_id
}