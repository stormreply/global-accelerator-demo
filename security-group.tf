resource "aws_security_group" "web" {
  for_each    = var.regions
  region      = each.value
  name        = local.deployment.name
  description = "Security group for web servers"
  vpc_id      = aws_default_vpc.default[each.value].id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.deployment.name
  }
}
