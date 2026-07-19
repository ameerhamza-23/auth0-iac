resource "auth0_client" "this" {
  name     = var.name
  app_type = var.app_type

  callbacks           = var.callbacks
  allowed_logout_urls = var.allowed_logout_urls

  oidc_conformant = true
}

resource "auth0_client_credentials" "this" {
  client_id = auth0_client.this.id

  authentication_method = var.authentication_method
}

# Only created for M2M apps (app_type = "non_interactive") that need to call an API on their own
# behalf - e.g. an Action's Management API client. Login apps (regular_web, spa) leave audience unset.
resource "auth0_client_grant" "this" {
  count = var.audience != null ? 1 : 0

  client_id = auth0_client.this.id
  audience  = var.audience
  scopes    = var.scopes
}
