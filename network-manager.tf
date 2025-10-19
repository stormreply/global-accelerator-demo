module "network-manager" {
  count  = var.create_network_manager ? 1 : 0
  source = "./network-manager"

  default_subnets = local.default_subnets
  default_vpcs    = aws_default_vpc.default
  loadbalancers   = local.loadbalancers
  name_tag        = local._name_tag
  regions         = var.regions
}
