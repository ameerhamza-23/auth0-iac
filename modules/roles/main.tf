resource "auth0_role" "this" {
  for_each = var.roles

  name        = each.key
  description = each.value.description
}

# Permissions must already exist on the API (see modules/api scopes). Skipped for roles with none,
# since the provider requires at least one permission.
resource "auth0_role_permissions" "this" {
  for_each = { for name, role in var.roles : name => role if length(role.permissions) > 0 }

  role_id = auth0_role.this[each.key].id

  dynamic "permissions" {
    for_each = each.value.permissions
    content {
      name                       = permissions.value.name
      resource_server_identifier = permissions.value.resource_server_identifier
    }
  }
}
