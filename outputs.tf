output "artifact" {
  description = "Artifact: A test script curl'ing the Global Accelerator URL"
  value       = "test.sh"
}

output "availability_zones" {
  value = local.availability_zones
}

output "global_accelerator" {
  description = "The Global Accelerator terraform object"
  value       = aws_globalaccelerator_accelerator.demo
}

output "endpoint_groups" {
  description = "The Global Accelerator endpoint groups"
  value       = aws_globalaccelerator_endpoint_group.demo
}

output "local_loadbalancers" {
  description = <<-EOD
    A list with all terraform loadbalancer objects involved
    in this Global Accelerator setup.
  EOD
  value       = local.loadbalancers
}

output "regions" {
  description = <<-EOD
    The configuration of all regions involved in this Global
    Accelerator setup.
  EOD
  value       = var.regions
}

output "_summary" {
  description = "Key-value pairs to be published in the GITHUB_STEP_SUMMARY"
  value = {
    "Global Accelerator" = "http://${aws_globalaccelerator_accelerator.demo.dns_name}"
    "Regions"            = var.regions
  }
}
