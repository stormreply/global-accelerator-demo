resource "aws_launch_template" "web" {
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
      echo -e "\n\nKeepAlive Off" >> /etc/httpd/conf/httpd.conf
      systemctl start httpd
      systemctl enable httpd
      echo "<h3>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</h3>" > /var/www/html/index.html
      echo "<h3>Region: ${each.key}</h3>" >> /var/www/html/index.html
      echo "OK" > /var/www/html/health
    EOF
  )
}
