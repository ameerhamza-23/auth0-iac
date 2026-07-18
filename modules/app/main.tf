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
