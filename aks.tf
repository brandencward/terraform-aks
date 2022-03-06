resource "azurerm_resource_group" "sandbox" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_kubernetes_cluster" "sandbox" {
  name                = var.akc_name
  location            = azurerm_resource_group.sandbox.location
  resource_group_name = azurerm_resource_group.sandbox.name
  dns_prefix          = var.akc_dns_prefix
  kubernetes_version = var.akc_kubernetes_version
  
  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = replace(var.akc_ssh_key,"\n","")
    }
  }

  default_node_pool {
    name       = var.akc_sys_nodepool_name
    node_count = var.akc_sys_node_count
    vm_size    = var.akc_sys_vm_size
    only_critical_addons_enabled = true // Only system Pods. No App Pods.
    orchestrator_version = var.akc_kubernetes_version
    enable_auto_scaling = true // Do not want for learning experience
    max_pods = var.akc_max_pods
    min_count = var.akc_min_count // Min Node pool should be 1 for Training.
    max_count = var. akc_max_count // Max Node pool for training should be low. Max of 3 for training.
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.akc_tags  
}

resource "azurerm_kubernetes_cluster_node_pool" "app_nodepool" {
  name                  = var.akc_cnp_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.sandbox.id
  vm_size               = var.akc_cnp_vm_size
  node_count            = var.akc_cnp_node_count
  mode = "User" // Specify User Apps. No System Pods.
  orchestrator_version = var.akc_kubernetes_version
  enable_auto_scaling = true // Do not want for learning experience
  max_pods = var.akc_max_pods
  min_count = var.akc_min_count // Min Node pool should be 1 for Training.
  max_count = var. akc_max_count // Max Node pool for training should be low. Max of 3 for training.

  tags = var.akc_tags
}