data "aws_availability_zones" "available" {
  for_each = var.regions
  region   = each.value
  state    = "available"
}
