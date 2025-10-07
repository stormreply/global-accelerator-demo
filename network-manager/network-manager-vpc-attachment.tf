resource "aws_networkmanager_vpc_attachment" "demo" {
  for_each = var.regions

  subnet_arns     = [for subnet in var.default_subnets[each.key] : subnet.arn]
  core_network_id = aws_networkmanager_core_network.demo.id
  vpc_arn         = var.default_vpcs[each.key].arn

  tags = {
    Name   = "${var.deployment.name}-vpc-${each.key}"
    Region = each.key
  }
}
