# Load balancer
resource "aws_lb" "load_balancer" {
  count = var.create_load_balancer ? 1 : 0
  name                             = "${var.environment}-${var.service}-lb"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.load_balancer.id]
  subnets                          = var.public_subnet_ids
  enable_cross_zone_load_balancing = true
  tags = {
    Name = "${var.environment}-${var.service}-public-load-balancer"
  }
}


# Make a conditional based rule here for if you are:
# NOT making your own LB
# Passing your own LB ARN to put this rule within
# IF create_load_balancer is true, DONT create this

resource "aws_lb_listener_rule" "nexus_forwarder_rule" {
  count = var.create_load_balancer ? 0 : 1
  listener_arn = var.listener_arn
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nexus_blue.arn
  }
  condition {
    host_header {
      values = aws_route53_record.nexus.*.fqdn
    }
  }
}