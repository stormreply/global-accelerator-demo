resource "aws_launch_template" "web" {
  for_each      = var.regions
  region        = each.key
  name          = local._name_tag
  image_id      = data.aws_ami.amazon_linux[each.key].id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.web[each.key].id]

  user_data = base64encode(<<-EOF
      #!/bin/bash
      yum update -y
      yum install -y httpd
      systemctl start httpd
      systemctl enable httpd
      echo "<h1>Region Server - ${each.key}</h1>" > /var/www/html/index.html
      echo "<p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>" >> /var/www/html/index.html
      echo "OK" > /var/www/html/health
    EOF
  )
}
