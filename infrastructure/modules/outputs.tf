output "aks_name" {
  value = module.aks.aks_name
}

output "kubeconfig" {
  value = module.aks.kubeconfig
  sensitive = true
}

output "vnet_id" {
  value = module.networking.vnet_id
}
