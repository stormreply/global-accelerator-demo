resource "aws_networkmanager_device" "loadbalancer" {
  for_each = var.loadbalancers

  global_network_id = aws_networkmanager_global_network.demo.id
  description       = "Load Balancer ${each.key} in ${each.value.region}"
  type              = "LOAD_BALANCER"
  site_id           = aws_networkmanager_site.regional[each.value.region].id

  tags = {
    Name              = "${var.name_tag}-alb-${each.key}"
    Region            = each.value.region
    LoadBalancerIndex = each.value.index
    Weight            = each.value.weight
  }
}
