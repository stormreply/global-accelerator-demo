data "cloudinit_config" "proxy" {
  for_each = var.regions

  gzip          = false
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = <<-EOF
      #cloud-config
      runcmd:
        - echo "BEGIN -- part 0 - init"
        - dnf install -y python3
        - echo "END -- part 0 - init"
    EOF
  }

  part {
    filename     = "01-start-proxyserver.sh"
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloudinit/01-start-proxyserver.py", {
      global_accelerator_url = "http://${aws_globalaccelerator_accelerator.demo.dns_name}"
    })
  }

  part {
    filename     = "02-start-webserver.sh"
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloudinit/02-start-webserver.sh", {
      region = each.key
    })
  }
}
