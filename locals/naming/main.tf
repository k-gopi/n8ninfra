locals {
  prefix = "${var.project}-${var.environment}-${var.location_short}"

  resource_group_name = "${local.prefix}-rg"
  vnet_name           = "${local.prefix}-vnet"
  aks_name            = "${local.prefix}-aks"
  appgw_name          = "${local.prefix}-appgw"
  keyvault_name       = "${replace(local.prefix, "-", "")}kv"
}