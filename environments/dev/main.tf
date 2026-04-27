module "tags" {
  source = "../../locals/tags"

  project     = var.project
  environment = var.environment
  owner       = var.owner
  cost_center = var.cost_center
}
module "naming" {
  source = "../../locals/naming"

  project        = var.project
  environment    = var.environment
  location_short = var.location_short
}

module "resource_group" {
  source = "../../modules/resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location

  tags = module.tags.tags   # ✅ FIX HERE
}
module "network" {
  source = "../../modules/network"

  vnet_name            = var.vnet_name
  location             = var.location
  resource_group_name  = module.resource_group.resource_group_name

  vnet_address_space           = var.vnet_address_space
  aks_subnet_prefix            = var.aks_subnet_prefix
  appgw_subnet_prefix          = var.appgw_subnet_prefix
  tags = module.tags.tags
}

module "aks" {
  source = "../../modules/aks"

  cluster_name        = module.naming.aks_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  kubernetes_version = var.kubernetes_version

  subnet_id = module.network.aks_subnet_id

  private_cluster_enabled = var.private_cluster_enabled
  #authorized_ip_ranges = var.authorized_ip_ranges
  sku_tier                = var.sku_tier

  oidc_issuer_enabled       = var.oidc_issuer_enabled
  workload_identity_enabled = var.workload_identity_enabled

  network_plugin = var.network_plugin
  network_policy = var.network_policy

  service_cidr   = var.service_cidr
  dns_service_ip = var.dns_service_ip
  outbound_type  = var.outbound_type

  system_node_pool = var.system_node_pool
  user_node_pools  = var.user_node_pools

  # ❌ removed app gateway (for now)
application_gateway_id = ""
authorized_ip_ranges = var.authorized_ip_ranges
  tags = module.tags.tags
}