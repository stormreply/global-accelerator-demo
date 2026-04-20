resource "aws_lb_listener" "demo" {
  # checkov:skip=CKV_AWS_2: "Ensure ALB protocol is HTTPS"
  # checkov:skip=CKV_AWS_103: "Ensure that load balancer is using at least TLS 1.2"
  # checkov:skip=CKV_AWS_378: "Ensure AWS Load Balancer doesn't use HTTP protocol"
  for_each          = local.loadbalancers
  region            = each.value.region
  load_balancer_arn = aws_lb.demo[each.key].arn
  port              = "80"
  protocol          = "HTTP"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo[each.key].arn
  }
}
