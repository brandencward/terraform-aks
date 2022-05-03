resource "azurerm_user_assigned_identity" "akc_identity" {
  resource_group_name = azurerm_resource_group.sandbox.name
  location            = azurerm_resource_group.sandbox.location

  name = "sandboxaks1-identity"
}

resource "azurerm_role_assignment" "akc_role_assignment" {
  scope                = azurerm_resource_group.sandbox.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_user_assigned_identity.akc_identity.principal_id
}

# Make second Identity and assign to the kubelet, right roles and permissions