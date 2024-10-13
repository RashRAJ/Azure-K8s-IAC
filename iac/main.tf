resource "azurerm_resource_group" "rg1" {
  name     = var.rgname
  location = var.location

  tags = {
    environment = "Raj-experiments"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = var.clustername
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  dns_prefix          = "${var.clustername}-dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v3"
  }

  role_based_access_control_enabled = true

  http_application_routing_enabled = true


  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  tags = {
    environment = "Raj-experiments"
  }

}



