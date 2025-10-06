resource "aws_lb_listener" "demo" {
  for_each          = local.loadbalancers
  region            = each.value.region
  load_balancer_arn = aws_lb.demo[each.key].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo[each.key].arn
  }
}
