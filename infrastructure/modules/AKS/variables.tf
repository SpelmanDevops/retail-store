variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "aks_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "node_pool_name" {
  description = "Name of the AKS node pool"
  type        = string
  default     = "default"
}

variable "node_count" {
  description = "Number of nodes in the AKS cluster"
  type        = number
}

variable "node_size" {
  description = "VM size for AKS nodes"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for AKS"
  type        = string
}

variable "tags" {
  description = "Tags for AKS resources"
  type        = map(string)
}
