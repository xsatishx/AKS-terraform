# Level 1 configs - create RG, VNET, SUBNET for AKS nodes and SUBNET for appgw

#  resource group.
resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "rg-${var.environment}-${var.application_code}-${var.unique_id}"
}

# vnet.
resource "azurerm_virtual_network" "vn" {
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  name                = "vnet-aks"
  address_space       = ["192.168.0.0/16"]
}

# AKS subnet
resource "azurerm_subnet" "subnet_aks" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "subnet-aks"
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["192.168.1.0/24"]
}

# AppGW Subnet
resource "azurerm_subnet" "subnet_appgw" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "subnet-appgw"
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["192.168.2.0/24"]
}
