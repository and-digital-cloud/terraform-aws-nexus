resource "aws_lb_listener" "https" {
  count = var.create_load_balancer  ? 1 : 0
  
  load_balancer_arn = aws_lb.load_balancer[count.index].arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.acm_wildcard_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nexus_blue.arn
    # target_group_arn = aws_lb_target_group.nexus_blue.arn
  }

  lifecycle {
    ignore_changes = [default_action]
  }

  tags = {
    Name = "${var.environment}-${var.service}-https"
  }
}

