locals {
  availability_zones = data.aws_availability_zones.available

  default_subnets = {
    for region in var.regions :
    region => [
      for subnet in aws_default_subnet.default :
      subnet if subnet.region == region
    ]
  }
}
