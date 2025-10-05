resource "aws_globalaccelerator_endpoint_group" "demo" {
  for_each                      = var.regions
  listener_arn                  = aws_globalaccelerator_listener.demo.id
  endpoint_group_region         = each.value
  traffic_dial_percentage       = 100
  health_check_interval_seconds = 30
  health_check_path             = "/health"
  health_check_protocol         = "HTTP"
  health_check_port             = 80
  threshold_count               = 3

  endpoint_configuration {
    endpoint_id = aws_lb.demo[each.value].arn
    weight      = 100
  }
}
