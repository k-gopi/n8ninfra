variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}
variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "aks_subnet_prefix" {
  type = list(string)
}

variable "appgw_subnet_prefix" {
  type = list(string)
}
variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "owner" {
  type = string
}

variable "cost_center" {
  type = string
}
variable "location_short" {
  type = string
}


variable "kubernetes_version" {
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

variable "system_node_pool" {
  type = any
}

variable "user_node_pools" {
  type = any
}
variable "application_gateway_id" {
  type    = string
  default = ""
}
variable "dns_prefix" {
  type    = string
  default = ""
}
variable "authorized_ip_ranges" {
  type = list(string)
}
variable "keyvault_name" {
  type = string
}
variable "keyvault_public_access" {
  type    = bool
  default = true   # dev only
}