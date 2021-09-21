################################################################################################
##                                        Nexus Security Group                                ##
################################################################################################

# Inbound Nexus Port
resource "aws_security_group_rule" "nexus_port" {
  description              = "Ingress Nexus port - 8081"
  from_port                = 8081
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nexus_security_group.id
  to_port                  = 8081
  type                     = "ingress"
  source_security_group_id = aws_security_group.load_balancer.id

}

# Allow EFS to Nexus
resource "aws_security_group_rule" "allow_nfs" {
  description              = "Ingress Nfs port - 2049"
  from_port                = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.efs_security_group.id
  security_group_id        = aws_security_group.nexus_security_group.id
  to_port                  = 2049
  type                     = "ingress"
}

# egress all
resource "aws_security_group_rule" "nexus_egress_all" {
  description       = "Egress all"
  type              = "egress"
  to_port           = 0
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.nexus_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}

################################################################################################
##                                        EFS Security Group                                  ##
################################################################################################

resource "aws_security_group_rule" "efs_ingress" {
  description              = "Allow efs traffic into mount target from ec2"
  type                     = "ingress"
  to_port                  = 2049
  from_port                = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.efs_security_group.id
  source_security_group_id = aws_security_group.nexus_security_group.id
}

resource "aws_security_group_rule" "efs_egress" {
  type                     = "egress"
  to_port                  = 2049
  from_port                = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.efs_security_group.id
  source_security_group_id = aws_security_group.nexus_security_group.id
}

################################################################################################
##                                        Load Balancer Security Group                        ##
################################################################################################

resource "aws_security_group_rule" "lb_ingress" {
  description       = "Ingress Nexus port 443"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.load_balancer.id
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = var.lb_ingress_rules
}

resource "aws_security_group_rule" "lb_nexus_egress" {
  description       = "Egress to nexus"
  type              = "egress"
  to_port           = 8081
  from_port         = 8081
  protocol          = "tcp"
  security_group_id = aws_security_group.load_balancer.id
  cidr_blocks       = ["0.0.0.0/0"]
}