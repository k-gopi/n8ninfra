variable "cluster_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "private_cluster_enabled" {
  type = bool
}

variable "sku_tier" {
  type = string
}

variable "oidc_issuer_enabled" {
  type = bool
}

variable "workload_identity_enabled" {
  type = bool
}

variable "network_plugin" {
  type = string
}

variable "network_policy" {
  type = string
}

variable "service_cidr" {
  type = string
}

variable "dns_service_ip" {
  type = string
}

variable "outbound_type" {
  type = string
}

variable "application_gateway_id" {
  type = string
}

variable "system_node_pool" {
  type = object({
    name                 = string
    vm_size              = string
    node_count           = number
    auto_scaling_enabled = bool
    min_nodes            = number
    max_nodes            = number
    max_pods             = number
    labels               = map(string)
    os_disk_size_gb     = number
    os_disk_type        = string
    os_sku              = string
  })
}

variable "user_node_pools" {
  type = map(object({
    name                 = string
    vm_size              = string
    node_count           = number
    auto_scaling_enabled = bool
    min_nodes            = number
    max_nodes            = number
    max_pods             = number
    labels               = map(string)
    os_disk_size_gb     = number
    os_disk_type        = string
    os_sku              = string
  }))
}
variable "dns_prefix" {
  type    = string
  default = ""
}

variable "tags" {
  type = map(string)
}
#variable "application_gateway_id" {
 # type    = string
 # default = ""
#}
variable "authorized_ip_ranges" {
  type    = list(string)
  default = []
}