resource "aws_default_vpc" "default" {
  for_each = var.regions
  region   = each.value
  tags = {
    Name = "Default VPC"
  }
}
