resource "aws_networkmanager_link" "regional" {
  for_each = var.regions

  global_network_id = aws_networkmanager_global_network.demo.id
  site_id           = aws_networkmanager_site.regional[each.key].id
  description       = "Network link for ${each.key}"

  bandwidth {
    upload_speed   = 10000 # Mbps
    download_speed = 10000 # Mbps
  }

  tags = {
    Name   = "${var.deployment.name}-link-${each.key}"
    Region = each.key
  }
}

resource "aws_networkmanager_link_association" "loadbalancer_to_site" {
  for_each = var.loadbalancers

  global_network_id = aws_networkmanager_global_network.demo.id
  device_id         = aws_networkmanager_device.loadbalancer[each.key].id
  link_id           = aws_networkmanager_link.regional[each.value.region].id
}
