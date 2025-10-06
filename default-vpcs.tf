resource "aws_default_vpc" "default" {
  for_each = var.regions
  region   = each.key
  tags = {
    Name = "Default VPC"
  }
}
