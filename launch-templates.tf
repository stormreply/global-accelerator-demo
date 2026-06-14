resource "aws_launch_template" "web" {
  # TODO: if need to log into instances, consider creating profile or SSM Default Host Management
  # checkov:skip=CKV_AWS_79: "Ensure Instance Metadata Service Version 1 is not enabled"
  for_each      = var.regions
  region        = each.key
  name          = local._deployment
  image_id      = data.aws_ami.amazon_linux[each.key].id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.web[each.key].id]

  iam_instance_profile {
    name = aws_iam_instance_profile.web.name
  }

  metadata_options {
    http_endpoint          = "enabled"
    http_tokens            = "required"
    instance_metadata_tags = "enabled"
  }

  user_data = data.cloudinit_config.web[each.key].rendered
}
