module "network-manager" {
  count  = var.create_network_manager ? 1 : 0
  source = "./network-manager"

  default_subnets = local.default_subnets
  default_vpcs    = aws_default_vpc.default
  deployment      = local._metadata
  loadbalancers   = local.loadbalancers
  regions         = var.regions
}
