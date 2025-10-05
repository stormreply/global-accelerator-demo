resource "aws_lb_target_group" "demo" {
  for_each = var.regions
  region   = each.value
  name     = local.deployment.name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_default_vpc.default[each.value].id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}
