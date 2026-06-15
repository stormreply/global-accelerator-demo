resource "null_resource" "copy_test_script" {
  provisioner "local-exec" {
    command = "cp ${path.module}/test.sh ${path.module}/${local._metadata.short_name}-test.sh"
  }
  triggers = {
    short_name = local._metadata.short_name
  }
}
