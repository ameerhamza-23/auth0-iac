# Scoped to username-password (strategy = "auth0") and google-oauth2 for now - other social/enterprise
# strategies need their own options{} fields added when actually used, rather than guessing at a
# generic passthrough (full auth0_connection.options schema is ~90 fields + ~15 nested blocks).

resource "auth0_connection" "this" {
  name     = var.name
  strategy = var.strategy

  options {
    # username-password (strategy = "auth0")
    password_policy         = var.password_policy
    brute_force_protection  = var.brute_force_protection
    requires_username       = var.requires_username
    disable_signup          = var.disable_signup

    # google-oauth2 - omit client_id/client_secret to fall back to Auth0's shared Dev Keys
    # (fine for testing, not for production - Auth0 rate-limits Dev Keys and shows a warning banner)
    client_id     = var.client_id
    client_secret = var.client_secret
    scopes        = var.scopes
  }
}
