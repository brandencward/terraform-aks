// Variables for specfic invironment that gets referenced in the command line.
// Works with variables.tf
rg_name = "sandbox-resources"
rg_location = "Central US"
akc_name = "sandbox-aks1"
akc_dns_prefix = "sandboxaks1"
akc_sys_nodepool_name = "system"
akc_sys_node_count = 1
akc_sys_vm_size = "Standard_D2_v2"
akc_tags = {
    Environment = "Production"
  }
akc_cnp_name = "app"
akc_cnp_vm_size = "Standard_DS2_v2"
akc_cnp_node_count = 1
akc_kubernetes_version = "1.20.7"
akc_max_pods = 100
akc_min_count = 1 // Min Node pool should be 1 for Training.
akc_max_count = 3 // Node pool for training should be low. Max of 3 for training. Prevents getting charged by accident.
