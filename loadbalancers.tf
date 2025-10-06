resource "aws_lb" "demo" {
  for_each           = local.loadbalancers
  region             = each.value.region
  name               = "${local.deployment.short_name}-${each.value.index}"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web[each.value.region].id]
  subnets            = local.default_subnets[each.value.region][*].id
}

locals {
  # make loadbalancer map with entries like
  # eu-central-1-0 = {
  #   index  = 0
  #   region = "eu-central-1"
  # }
  loadbalancers = merge([
    for region, idx_map in {
      for region, value in var.regions :
      region => {
        for index in range(length(value.endpoint_configuration_weights)) : index => {
          "region" = region
          "index"  = index
          "weight" = value.endpoint_configuration_weights[index]
        }
      }
    } :
    { # object in list, not map value
      for idx, obj in idx_map :
      "${region}-${idx}" => obj
    }
  ]...)
}
