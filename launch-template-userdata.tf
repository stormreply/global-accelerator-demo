data "cloudinit_config" "web" {
  for_each = var.regions

  gzip          = false
  base64_encode = true

  part {
    filename     = "00-cloud-config.yaml"
    content_type = "text/cloud-config"
    content      = <<-EOC
      #cloud-config
      write_files:
        - path: /var/www/html/architecture.drawio.svg
          permissions: '0644'
          owner: root:root
          encoding: b64
          content: ${base64encode(file("${path.module}/assets/architecture.drawio.svg"))}
        - path: /var/www/html/architecture.inverted.svg
          permissions: '0644'
          owner: root:root
          encoding: b64
          content: ${base64encode(file("${path.module}/assets/architecture.inverted.svg"))}
        - path: /var/www/html/architecture.black.svg
          permissions: '0644'
          owner: root:root
          encoding: b64
          content: ${base64encode(file("${path.module}/assets/architecture.inverted.svg"))}
        - path: /var/www/html/demo.html
          permissions: '0644'
          owner: root:root
          encoding: b64
          content: ${base64encode(file("${path.module}/assets/demo.html"))}
    EOC
  }

  part {
    filename     = "01-start-proxyserver.py"
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloudinit/01-start-proxyserver.py", {
      global_accelerator_url = "http://${aws_globalaccelerator_accelerator.demo.dns_name}"
    })
  }

  part {
    filename     = "02-start-webserver.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/cloudinit/02-start-webserver.sh")
  }
}
