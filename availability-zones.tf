data "aws_availability_zones" "available" {
  for_each = var.regions
  region   = each.key
  state    = "available"
}

locals {
  availability_zones = data.aws_availability_zones.available
}
