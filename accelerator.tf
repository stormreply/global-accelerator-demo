resource "aws_globalaccelerator_accelerator" "demo" {
  # checkov:skip=CKV_AWS_75: "Ensure Global Accelerator accelerator has flow logs enabled"
  name            = local._deployment
  ip_address_type = "IPV4"
  enabled         = true
}
