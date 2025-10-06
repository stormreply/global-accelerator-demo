resource "aws_default_subnet" "default" {
  for_each = toset(flatten([
    for key, value in local.availability_zones : value.names
  ]))
  availability_zone = each.value
  region            = substr(each.value, 0, length(each.value) - 1)
  tags = {
    Name = "Default subnet for ${each.value}"
  }
}

locals {
  default_subnets = {
    for region, _ in var.regions :
    region => [
      for subnet in aws_default_subnet.default :
      subnet if subnet.region == region
    ]
  }
}
