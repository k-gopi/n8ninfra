# -------------------------
# VNET
# -------------------------
resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space

  tags = var.tags
}

# -------------------------
# AKS SUBNET (STATIC NAME - IMPORTANT FIX)
# -------------------------
resource "azurerm_subnet" "aks" {
  name                 = "aks-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.aks_subnet_prefix
}

# -------------------------
# APP GATEWAY SUBNET (STATIC NAME - IMPORTANT FIX)
# -------------------------
resource "azurerm_subnet" "appgw" {
  name                 = "appgw-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.appgw_subnet_prefix
}

# -------------------------
# NSG - AKS
# -------------------------
resource "azurerm_network_security_group" "aks_nsg" {
  name                = "${var.vnet_name}-aks-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# -------------------------
# NSG - APPGW
# -------------------------
resource "azurerm_network_security_group" "appgw_nsg" {
  name                = "${var.vnet_name}-appgw-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# -------------------------
# NSG ASSOCIATION - AKS
# -------------------------
resource "azurerm_subnet_network_security_group_association" "aks_assoc" {
  subnet_id                 = azurerm_subnet.aks.id
  network_security_group_id = azurerm_network_security_group.aks_nsg.id
}

# -------------------------
# NSG ASSOCIATION - APPGW
# -------------------------
resource "azurerm_subnet_network_security_group_association" "appgw_assoc" {
  subnet_id                 = azurerm_subnet.appgw.id
  network_security_group_id = azurerm_network_security_group.appgw_nsg.id
}