resource "aws_autoscaling_group" "web" {
  for_each = local.loadbalancers
  region   = each.value.region
  name = join("-", [
    local._metadata.short_name,
    local.region_shortcut[each.value.region],
    each.value.index
  ])
  vpc_zone_identifier = local.default_subnets[each.value.region][*].id
  target_group_arns   = [aws_lb_target_group.demo[each.key].arn]
  health_check_type   = "ELB"
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  launch_template {
    id      = aws_launch_template.web[each.value.region].id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${local._metadata.short_name}-${each.value.index}"
    propagate_at_launch = true
  }

  # dynamic "tag" {
  #   for_each = var.tags
  #   content {
  #     key                 = tag.key
  #     value               = tag.value
  #     propagate_at_launch = true
  #   }
  # }
}
