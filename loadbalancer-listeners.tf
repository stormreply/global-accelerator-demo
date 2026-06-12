resource "aws_lb_listener" "web" {
  # checkov:skip=CKV_AWS_2: "Ensure ALB protocol is HTTPS"
  # checkov:skip=CKV_AWS_103: "Ensure that load balancer is using at least TLS 1.2"
  # checkov:skip=CKV_AWS_378: "Ensure AWS Load Balancer doesn't use HTTP protocol"
  for_each          = local.loadbalancers
  region            = each.value.region
  load_balancer_arn = aws_lb.demo[each.key].arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web[each.key].arn
  }
}

resource "aws_lb_listener_rule" "proxy" {
  for_each     = local.loadbalancers
  region       = each.value.region
  listener_arn = aws_lb_listener.web[each.key].arn

  condition {
    path_pattern {
      values = ["/proxy", "/proxy/*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.proxy[each.key].arn
  }
}
