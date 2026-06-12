resource "aws_security_group" "web" {
  # checkov:skip=CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
  # checkov:skip=CKV_AWS_382: "Ensure no security groups allow egress from 0.0.0.0:0 to port -1"
  # checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
  for_each    = var.regions
  region      = each.key
  name        = local._deployment
  description = "Security group for ${local._deployment} endpoint servers in ${each.key}"
  vpc_id      = aws_default_vpc.default[each.key].id

  ingress {
    description = "Allow incoming web traffic on port 80 (HTTP)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow incoming proxy traffic on port 8080 (HTTP)"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all kinds of outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local._deployment
  }
}
