resource "aws_lb_target_group" "demo" {
  for_each = local.loadbalancers
  region   = each.value.region
  name     = "${local._metadata.short_name}-${each.value.index}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_default_vpc.default[each.value.region].id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 5
    matcher             = "200"
    path                = "/" # /health
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 2
    unhealthy_threshold = 2
  }
}
