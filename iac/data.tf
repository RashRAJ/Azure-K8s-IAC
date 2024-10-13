data "azurerm_kubernetes_cluster" "default" {
  name                = var.clustername
  resource_group_name = var.rgname
}

data "azurerm_public_ip" "public_lb" {
  name                = var.public_lb
  resource_group_name = "MC_RAJ-AKS-RG_RAJ-AZcluster_northeurope"
}
