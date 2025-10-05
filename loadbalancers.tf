resource "aws_lb" "demo" {
  for_each           = var.regions
  region             = each.value
  name               = local.deployment.short_name
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web[each.value].id]
  subnets            = local.default_subnets[each.value][*].id
}
