resource "aws_lb_listener" "demo" {
  for_each          = var.regions
  region            = each.value
  load_balancer_arn = aws_lb.demo[each.value].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo[each.value].arn
  }
}
