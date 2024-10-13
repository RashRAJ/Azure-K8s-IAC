output "resource_group_name" {
  value = azurerm_resource_group.rg1.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.default.name
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.default.kube_config.0.client_certificate
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.default.kube_config.0.client_key
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.default.kube_config_raw
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate
  sensitive = true
}

output "id" {
  value     = azurerm_kubernetes_cluster.default.id
  sensitive = true
}

output "host" {
  value     = azurerm_kubernetes_cluster.default.kube_config.0.host
  sensitive = true
}