resource "aws_globalaccelerator_listener" "demo" {
  accelerator_arn = aws_globalaccelerator_accelerator.demo.id

  # From https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/globalaccelerator_listener:
  #
  # Direct all requests from a user to the same endpoint. Valid
  # values are NONE, SOURCE_IP. Default: NONE.
  #
  # If NONE, Global Accelerator uses the "five-tuple" properties
  # of source IP address, source port, destination IP address,
  # destination port, and protocol to select the hash value. If
  # SOURCE_IP, Global Accelerator uses the "two-tuple" properties
  # of source (client) IP address and destination IP address to
  # select the hash value.
  #
  # NOTE that browsers might use TCP keep alive and re-use the
  # port. In order to show distribution over multiple endpoints,
  # use curl -s --no-keepalive http://<GA-DNS-Name>
  # See also: https://docs.aws.amazon.com/global-accelerator/latest/dg/about-listeners-client-affinity.html
  #
  client_affinity = "NONE"

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
