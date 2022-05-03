resource "azurerm_key_vault" "kv" {
  name                        = "${var.kv_name}-${var.slug}"
  location                    = azurerm_resource_group.sandbox.location
  resource_group_name         = azurerm_resource_group.sandbox.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = var.kv_soft_delete_retention_days
  purge_protection_enabled    = false

  sku_name = var.kv_sku_name
  count = var.kv_enabled

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Backup", "Create", "Decrypt", "Delete", "Encrypt", 
      "Get", "Import", "List", "Purge", "Recover", "Restore", 
      "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"
    ]

    secret_permissions = [
      "Backup", "Delete", "Get", "List", "Purge", "Recover", 
      "Restore", "Set"
    ]

    storage_permissions = [
      "Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", 
      "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", 
      "Set", "SetSAS", "Update"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_user_assigned_identity.akc_identity.principal_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }
}