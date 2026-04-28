resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name

  kubernetes_version = var.kubernetes_version
  dns_prefix = var.dns_prefix != "" ? var.dns_prefix : "${var.cluster_name}-dns"
  private_cluster_enabled = var.private_cluster_enabled
  sku_tier                = var.sku_tier

  oidc_issuer_enabled       = var.oidc_issuer_enabled
  workload_identity_enabled = var.workload_identity_enabled

  identity {
    type = "SystemAssigned"
  }
  key_vault_secrets_provider {
  secret_rotation_enabled = true
}

  # -------------------------
  # SYSTEM NODE POOL
  # -------------------------
  default_node_pool {
    name           = var.system_node_pool.name
    vm_size        = var.system_node_pool.vm_size
    node_count     = var.system_node_pool.node_count
    vnet_subnet_id = var.subnet_id

    auto_scaling_enabled = var.system_node_pool.auto_scaling_enabled
    min_count            = var.system_node_pool.min_nodes
    max_count            = var.system_node_pool.max_nodes

    max_pods    = var.system_node_pool.max_pods
    node_labels = var.system_node_pool.labels

    only_critical_addons_enabled = true

    os_disk_size_gb = var.system_node_pool.os_disk_size_gb
    os_disk_type    = var.system_node_pool.os_disk_type
    os_sku          = var.system_node_pool.os_sku
  }

  # -------------------------
  # NETWORK
  # -------------------------
  network_profile {
    network_plugin = var.network_plugin
    network_policy = var.network_policy

    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
    outbound_type  = var.outbound_type
  }

  dynamic "api_server_access_profile" {
  for_each = length(var.authorized_ip_ranges) > 0 ? [1] : []
  content {
    authorized_ip_ranges = var.authorized_ip_ranges
  }
}
  # -------------------------
  # APP GATEWAY INTEGRATION (OPTIONAL)
  # -------------------------
  dynamic "ingress_application_gateway" {
    for_each = var.application_gateway_id != "" ? [1] : []
    content {
      gateway_id = var.application_gateway_id
    }
  }

  tags = var.tags
}

# -------------------------
# USER NODE POOLS
# -------------------------
resource "azurerm_kubernetes_cluster_node_pool" "user" {
  for_each = var.user_node_pools

  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id

  vm_size        = each.value.vm_size
  node_count     = each.value.node_count
  vnet_subnet_id = var.subnet_id

  mode = "User"

  auto_scaling_enabled = each.value.auto_scaling_enabled
  min_count            = each.value.min_nodes
  max_count            = each.value.max_nodes

  max_pods    = each.value.max_pods
  node_labels = each.value.labels

  os_sku    = each.value.os_sku
  os_type   = "Linux"

  os_disk_size_gb = each.value.os_disk_size_gb
  os_disk_type    = each.value.os_disk_type

  tags = var.tags
}


