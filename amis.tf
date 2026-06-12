data "aws_ami" "amazon_linux" {
  for_each    = var.regions
  region      = each.key
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}
