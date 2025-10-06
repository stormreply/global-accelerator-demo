data "aws_ami" "amazon_linux" {
  for_each    = var.regions
  region      = each.key
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
