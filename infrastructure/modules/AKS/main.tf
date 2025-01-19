resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.node_pool_name
    node_count = 1                  # Single node for cost optimization
    vm_size    = "Standard_B2s"     # Cheapest VM size for AKS
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"         # Free managed identity
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.1.0.0/16"   
    dns_service_ip = "10.1.0.10"    
 
  }

  tags = var.tags
}
