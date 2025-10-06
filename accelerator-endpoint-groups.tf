resource "aws_globalaccelerator_endpoint_group" "demo" {
  for_each                      = var.regions
  listener_arn                  = aws_globalaccelerator_listener.demo.id
  endpoint_group_region         = each.key
  traffic_dial_percentage       = 100
  health_check_interval_seconds = 10
  health_check_path             = "/"    # /health
  health_check_protocol         = "HTTP" # TCP
  health_check_port             = 80
  threshold_count               = 3

  dynamic "endpoint_configuration" {
    for_each = {
      for loadbalancer, value in local.loadbalancers :
      loadbalancer => value if value.region == each.key
    }
    content {
      endpoint_id = aws_lb.demo[endpoint_configuration.key].arn
      weight      = endpoint_configuration.value.weight
    }
  }
}
