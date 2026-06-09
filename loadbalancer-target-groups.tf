resource "aws_lb_target_group" "demo" {
  # checkov:skip=CKV_AWS_378: "Ensure AWS Load Balancer doesn't use HTTP protocol"
  for_each = local.loadbalancers
  region   = each.value.region
  name     = "${local._metadata.short_name}-${each.value.index}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_default_vpc.default[each.value.region].id

  health_check {
    enabled = true

    # Number of consecutive health check successes required before considering
    # a target healthy. The range is 2-10.
    healthy_threshold = 2

    # Approximate amount of time, in seconds, between health checks of an
    # individual target. The range is 5-300.
    interval = 5

    matcher  = "200"
    path     = "/" # /health
    port     = "traffic-port"
    protocol = "HTTP"

    # Amount of time, in seconds, during which no response from a target
    # means a failed health check. The range is 2–120 seconds.
    timeout = 2

    # Number of consecutive health check failures required before considering
    # a target unhealthy. The range is 2-10.
    unhealthy_threshold = 2
  }
}
