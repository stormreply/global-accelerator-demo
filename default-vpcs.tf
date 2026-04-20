resource "aws_default_vpc" "default" {
  # checkov:skip=CKV_AWS_148: Managing existing default VPC, not creating a new one
  for_each = var.regions
  region   = each.key
  tags = {
    Name = "Default VPC"
  }
}
