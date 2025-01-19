output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
  sensitive = true
}

output "node_pool_name" {
  value = azurerm_kubernetes_cluster.aks.default_node_pool[0].name
}
