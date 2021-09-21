# Blue Target Group - Nexus
resource "aws_lb_target_group" "nexus_blue" {
  health_check {
    interval            = 60
    path                = "/service/rest/v1/status/writable"
    protocol            = "HTTP"
    timeout             = 30
    healthy_threshold   = 3
    unhealthy_threshold = 5
    # Doesn't inform asg to load another box 
    # On asg set health check type to ec2
  }

  name        = "${var.environment}-nexus-blue"
  port        = 8081
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  tags = {
    Name = "${var.environment}-${var.service}-nexus-blue-target-group"
  }

  lifecycle {
    create_before_destroy = true
  }
}
