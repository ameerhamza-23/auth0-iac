variable "policy" {
  type        = string
  default     = "all-applications"
  description = "When MFA is required: \"never\", \"all-applications\" or \"confidence-score\" (adaptive)"
}

variable "otp" {
  type        = bool
  default     = true
  description = "One-time password (authenticator app) factor"
}

variable "email" {
  type        = bool
  default     = false
  description = "Email factor"
}

variable "recovery_code" {
  type        = bool
  default     = true
  description = "Recovery code factor"
}

variable "webauthn_platform" {
  type        = bool
  default     = false
  description = "WebAuthn with device biometrics (Face ID, Touch ID, Windows Hello)"
}

variable "webauthn_roaming" {
  type = object({
    user_verification = optional(string, "preferred")
  })
  default     = null
  description = "WebAuthn with FIDO security keys; null disables the factor"
}

variable "settings" {
  type = object({
    display_remember_me_checkbox   = optional(bool, true)
    remember_me_default_value      = optional(bool, false)
    mfa_session_inactivity_timeout = optional(number, 604800)
    mfa_session_overall_timeout    = optional(number, 2592000)
  })
  default     = {}
  description = "How often users are re-prompted for MFA (seconds) and 'Remember me' behavior"
}
