resource "auth0_organization" "this" {
  name         = var.name
  display_name = var.display_name
  metadata     = var.metadata

  dynamic "branding" {
    for_each = var.logo_url != null || var.colors != null ? [1] : []
    content {
      logo_url = var.logo_url
      colors   = var.colors
    }
  }
}

# Skipped when empty - the provider requires at least one connection / client.
resource "auth0_organization_connections" "this" {
  count = length(var.connections) > 0 ? 1 : 0

  organization_id = auth0_organization.this.id

  dynamic "enabled_connections" {
    for_each = var.connections
    content {
      connection_id              = enabled_connections.value.connection_id
      assign_membership_on_login = enabled_connections.value.assign_membership_on_login
      show_as_button             = enabled_connections.value.show_as_button
    }
  }
}

resource "auth0_organization_clients" "this" {
  count = length(var.client_ids) > 0 ? 1 : 0

  organization_id = auth0_organization.this.id

  dynamic "clients" {
    for_each = var.client_ids
    content {
      client_id = clients.value
    }
  }
}
