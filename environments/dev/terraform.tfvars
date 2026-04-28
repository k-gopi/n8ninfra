project     = "n8n"
environment = "dev"
owner       = "gopi"
cost_center = "platform"
resource_group_name = "n8n-dev-rg"
location       = "eastus2"
location_short = "EUS2"

vnet_name = "n8n-dev-vnet"

vnet_address_space = ["10.0.0.0/8"]

aks_subnet_prefix = ["10.10.1.0/24"]

appgw_subnet_prefix = ["10.10.2.0/24"]

#aks

kubernetes_version  = "1.35.1"

private_cluster_enabled = false
sku_tier                = "Free"

oidc_issuer_enabled       = false
workload_identity_enabled  = false

network_plugin = "azure"
network_policy = "azure"

service_cidr   = "10.200.0.0/16"
dns_service_ip = "10.200.0.10"
outbound_type  = "loadBalancer"
authorized_ip_ranges = [
  "157.48.173.152"
]

# -------------------------
# SMALL SYSTEM NODE POOL
# -------------------------
system_node_pool = {
  name                 = "system"
  vm_size              = "Standard_B2s"   # 🔽 smaller VM (cheap testing)
  node_count           = 1                # 🔽 single node
  auto_scaling_enabled = true
  min_nodes            = 1
  max_nodes            = 2
  max_pods             = 30               # 🔽 reduced pods

  labels = {
    role = "system"
  }

  os_disk_size_gb = 64                   # 🔽 reduced disk
  os_disk_type    = "Managed"
  os_sku          = "Ubuntu"
}

# -------------------------
# SMALL USER NODE POOL
# -------------------------
user_node_pools = {
  user = {
    name                 = "user"
    vm_size              = "Standard_B2s"  # 🔽 same small VM
    node_count           = 1               # 🔽 single node
    auto_scaling_enabled = true
    min_nodes            = 1
    max_nodes            = 2
    max_pods             = 30              # 🔽 reduced pods

    labels = {
      role = "worker"
    }

    os_disk_size_gb = 64
    os_disk_type    = "Managed"
    os_sku          = "Ubuntu"
  }
}
keyvault_name = "n8n-dev-eus2-kv"