resource "aws_globalaccelerator_listener" "demo" {
  accelerator_arn = aws_globalaccelerator_accelerator.demo.id
  # client_affinity = "SOURCE_IP" # NONE
  protocol = "TCP"

  port_range {
    from_port = 80
    to_port   = 80
  }

  port_range {
    from_port = 443
    to_port   = 443
  }
}
