resource "auth0_resource_server" "this" {
  name       = var.name
  identifier = var.identifier

  signing_alg          = var.signing_alg
  token_lifetime       = var.token_lifetime
  allow_offline_access = var.allow_offline_access
  enforce_policies     = var.enforce_policies
  token_dialect        = var.token_dialect

  skip_consent_for_verifiable_first_party_clients = var.skip_consent_for_verifiable_first_party_clients
}

# Managed as a separate resource rather than inline `scopes` blocks on auth0_resource_server (deprecated
# there). The provider requires at least one scope, so skip it entirely when none are given.
resource "auth0_resource_server_scopes" "this" {
  count = length(var.scopes) > 0 ? 1 : 0

  resource_server_identifier = auth0_resource_server.this.identifier

  dynamic "scopes" {
    for_each = var.scopes
    content {
      name        = scopes.value.name
      description = scopes.value.description
    }
  }
}
