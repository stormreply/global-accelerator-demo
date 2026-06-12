resource "aws_launch_template" "web" {
  # TODO: if need to log into instances, consider creating profile or SSM Default Host Management
  # checkov:skip=CKV_AWS_79: "Ensure Instance Metadata Service Version 1 is not enabled"
  for_each      = var.regions
  region        = each.key
  name          = local._deployment
  image_id      = data.aws_ami.amazon_linux[each.key].id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.web[each.key].id]

  user_data = base64encode(<<-EOF
      #!/bin/bash
      yum update -y
      yum install -y httpd
      systemctl start httpd
      systemctl enable httpd
      cat << EOS >> /var/www/html/index.html
      <style>
      * { font-family: sans-serif; margin: 20px; }
      </style>
      <!-- Instance ID --><h2>$(curl -s http://169.254.169.254/latest/meta-data/instance-id)</h2>
      <!-- Region --><h2>${each.key}</h2>
      EOS
      echo "OK" > /var/www/html/health
    EOF
  )
}
