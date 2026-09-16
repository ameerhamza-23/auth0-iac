# Tenant-wide settings - a singleton, one per Auth0 tenant. Applying this takes over the whole
# tenant's settings, so any field left null here is reset to Auth0's default on the next apply.
resource "auth0_tenant" "this" {
  friendly_name = var.friendly_name
  picture_url   = var.picture_url
  support_email = var.support_email
  support_url   = var.support_url

  allowed_logout_urls = var.allowed_logout_urls
  default_audience    = var.default_audience
  default_directory   = var.default_directory
  enabled_locales     = var.enabled_locales

  session_lifetime      = var.session_lifetime
  idle_session_lifetime = var.idle_session_lifetime

  session_cookie {
    mode = var.session_cookie_mode
  }

  sessions {
    oidc_logout_prompt_enabled = var.oidc_logout_prompt_enabled
  }

  flags {
    enable_client_connections              = var.flags.enable_client_connections
    enable_public_signup_user_exists_error = var.flags.enable_public_signup_user_exists_error
    disable_clickjack_protection_headers   = var.flags.disable_clickjack_protection_headers
    revoke_refresh_token_grant             = var.flags.revoke_refresh_token_grant
    use_scope_descriptions_for_consent     = var.flags.use_scope_descriptions_for_consent
  }
}
