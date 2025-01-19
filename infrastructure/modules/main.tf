terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" 
    }
  }
  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}
}

module "networking" {
  source                = "./networking"
  resource_group_name   = "aks-resource-group"
  location              = "UKSouth"
  vnet_name             = "aks-vnet"
  address_space         = ["10.0.0.0/16"]
  subnet_name           = "aks-subnet"
  subnet_address_prefixes = ["10.0.1.0/24"]
  nsg_name              = "aks-nsg"
}

module "aks" {
  source                = "./aks"
  resource_group_name   = module.networking.resource_group_name
  location              = "UKSouth"
  aks_name              = "aks-cluster"
  dns_prefix            = "aks-demo"
  node_pool_name        = "default"
  node_count            = 1
  node_size             = "Standard_DS2_v2"
  subnet_id             = module.networking.subnet_id
  tags                  = {
    environment = "dev"
  }
}
