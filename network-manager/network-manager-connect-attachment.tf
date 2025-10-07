resource "aws_networkmanager_connect_attachment" "accelerator_endpoints" {
  for_each = var.regions

  core_network_id         = aws_networkmanager_core_network.demo.id
  transport_attachment_id = aws_networkmanager_vpc_attachment.demo[each.key].id
  edge_location           = each.key

  options {
    protocol = "GRE"
  }

  tags = {
    Name   = "${var.deployment.name}-connect-${each.key}"
    Region = each.key
  }
}
