resource "aws_globalaccelerator_accelerator" "demo" {
  # checkov:skip=CKV_AWS_75: "Ensure Global Accelerator accelerator has flow logs enabled"
  name            = local._deployment
  ip_address_type = "IPV4"
  enabled         = true

  # attributes {
  #   flow_logs_enabled   = true
  #   flow_logs_s3_bucket = aws_s3_bucket.flow_logs.bucket
  #   flow_logs_s3_prefix = "flow-logs/"
  # }
}
