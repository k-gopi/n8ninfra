resource "azurerm_key_vault" "this" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"

  # Security best practices
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7

  # RBAC enabled (recommended instead of access policies)
  rbac_authorization_enabled = true

  # Network security (optional but recommended)
  public_network_access_enabled = var.public_network_access_enabled

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

  tags = var.tags
}