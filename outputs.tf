output "amis" {
  value = data.aws_ami.amazon_linux
}

output "availability_zones" {
  value = local.availability_zones
}

output "default_subnets" {
  value = local.default_subnets
}

output "default_tags" {
  value = local.default_tags
}

output "default_vpcs" {
  value = aws_default_vpc.default
}

output "global_accelerator" {
  value = aws_globalaccelerator_accelerator.demo
}

output "loadbalancers" {
  value = aws_lb.demo
}

output "regions" {
  value = var.regions
}
