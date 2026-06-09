resource "aws_globalaccelerator_endpoint_group" "demo" {
  for_each              = var.regions
  listener_arn          = aws_globalaccelerator_listener.demo.id
  endpoint_group_region = each.key

  # The time—10 seconds or 30 seconds—between each health check for an endpoint.
  health_check_interval_seconds = 10

  health_check_path     = "/"    # /health
  health_check_protocol = "HTTP" # TCP
  health_check_port     = 80

  # The number of consecutive health checks required to set the state of a
  # healthy endpoint to unhealthy, or to set an unhealthy endpoint to healthy.
  threshold_count = 1

  # The percentage of traffic to send to an AWS Region. Default 100 means
  # every client would be routed to the closest endpoint (group).
  traffic_dial_percentage = 100

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
