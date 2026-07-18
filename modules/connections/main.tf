# Scoped to username-password (strategy = "auth0") for now. Social strategies (google-oauth2, etc.)
# need a different options{} shape (client_id/client_secret/scopes instead of password policy fields) -
# expand this when actually adding one, rather than guessing at a generic passthrough now.

resource "auth0_connection" "this" {
  name     = var.name
  strategy = var.strategy

  options {
    password_policy         = var.password_policy
    brute_force_protection  = var.brute_force_protection
    requires_username       = var.requires_username
    disable_signup          = var.disable_signup
  }
}
