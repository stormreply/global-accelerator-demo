resource "aws_lb" "demo" {
  # checkov:skip=CKV_AWS_2: "Ensure ALB protocol is HTTPS"
  # checkov:skip=CKV_AWS_91: "Ensure the ELBv2 (Application/Network) has access logging enabled"
  # checkov:skip=CKV_AWS_131: "Ensure that ALB drops HTTP headers"
  # checkov:skip=CKV_AWS_150: "Ensure that Load Balancer has deletion protection enabled"
  # checkov:skip=CKV2_AWS_20: "Ensure that ALB redirects HTTP requests into HTTPS ones"
  # checkov:skip=CKV2_AWS_28: "Ensure public facing ALB are protected by WAF"
  for_each = local.loadbalancers
  region   = each.value.region
  name = join("-", [
    local._metadata.short_name,
    local.region_shortcut[each.value.region],
    each.value.index
  ])
  load_balancer_type = "application"

  # for the sake of the demo, we try to close a connection as soon as possible
  # in order to better be able to demonstrate the dial and weight features of
  # Global Accelerator. Curl will close the connection reight after the call,
  # but browsers will try to keep the connection for better user experience.
  # below settings should help to get rid of a connection as quick as possible.
  #
  enable_http2      = false # http2 would try to keep conn open
  client_keep_alive = 60    # 60 seconds is the minumum
  idle_timeout      = 1     #  1 second  is the minimum

  security_groups = [aws_security_group.web[each.value.region].id]
  subnets         = local.default_subnets[each.value.region][*].id
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
