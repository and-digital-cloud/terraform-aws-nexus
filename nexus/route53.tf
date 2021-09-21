resource "aws_route53_record" "nexus" {
  count   = var.create_load_balancer && (var.public_zone_id != null || var.service != null) ? 1 : 0
  zone_id = var.public_zone_id
  name    = var.service
  type    = "A"
  alias {
    name                   = aws_lb.load_balancer[count.index].dns_name
    zone_id                = aws_lb.load_balancer[count.index].zone_id
    evaluate_target_health = false # Is this really necessary to turn on in this example? We're not going to do any load balancing between instance groups
  }
}

