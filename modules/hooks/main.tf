# legacy - Auth0 recommends auth0_action instead, kept here for learning/comparison only.
# Hooks only cover the credentials-exchange, pre/post-user-registration, post-change-password and
# send-phone-message triggers; new Auth0 tenants can't create them at all, so applying this against
# one will be rejected by the API.
resource "auth0_hook" "this" {
  name       = var.name
  script     = var.script
  trigger_id = var.trigger_id
  enabled    = var.enabled

  dependencies = var.dependencies
  secrets      = var.secrets
}
