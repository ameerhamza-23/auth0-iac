# Singleton - tenant-wide MFA policy and factors. A factor block's presence enables it, so the
# dynamic blocks below are only rendered for the factors turned on in var.
resource "auth0_guardian" "this" {
  policy        = var.policy
  otp           = var.otp
  email         = var.email
  recovery_code = var.recovery_code

  settings {
    display_remember_me_checkbox   = var.settings.display_remember_me_checkbox
    remember_me_default_value      = var.settings.remember_me_default_value
    mfa_session_inactivity_timeout = var.settings.mfa_session_inactivity_timeout
    mfa_session_overall_timeout    = var.settings.mfa_session_overall_timeout
  }

  dynamic "webauthn_platform" {
    for_each = var.webauthn_platform ? [1] : []
    content {
      enabled = true
    }
  }

  dynamic "webauthn_roaming" {
    for_each = var.webauthn_roaming != null ? [var.webauthn_roaming] : []
    content {
      enabled           = true
      user_verification = webauthn_roaming.value.user_verification
    }
  }
}
