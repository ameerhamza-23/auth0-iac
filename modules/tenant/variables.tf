variable "friendly_name" {
  type        = string
  default     = null
  description = "Friendly name of the tenant"
}

variable "picture_url" {
  type        = string
  default     = null
  description = "Tenant logo URL (150x150px recommended)"
}

variable "support_email" {
  type        = string
  default     = null
  description = "Support email address shown to users"
}

variable "support_url" {
  type        = string
  default     = null
  description = "Support URL shown to users"
}

variable "allowed_logout_urls" {
  type        = list(string)
  default     = null
  description = "Tenant-level URLs Auth0 may redirect to after logout (in addition to each app's own list)"
}

variable "default_audience" {
  type        = string
  default     = null
  description = "API audience appended to every authorization request that doesn't specify one"
}

variable "default_directory" {
  type        = string
  default     = null
  description = "Name of the database connection used for Password Grant exchanges"
}

variable "enabled_locales" {
  type        = list(string)
  default     = ["en"]
  description = "Supported UI locales; the first one is the default"
}

variable "session_lifetime" {
  type        = number
  default     = 168
  description = "Hours a session stays valid"
}

variable "idle_session_lifetime" {
  type        = number
  default     = 72
  description = "Hours a session may be inactive before the user must log in again"
}

variable "session_cookie_mode" {
  type        = string
  default     = "persistent"
  description = "\"persistent\" or \"non-persistent\" session cookie"
}

variable "oidc_logout_prompt_enabled" {
  type        = bool
  default     = false
  description = "Ask users to confirm RP-initiated logout requests that aren't trustworthy"
}

variable "flags" {
  type = object({
    enable_client_connections              = optional(bool, false)
    enable_public_signup_user_exists_error = optional(bool, true)
    disable_clickjack_protection_headers   = optional(bool, false)
    revoke_refresh_token_grant             = optional(bool, true)
    use_scope_descriptions_for_consent     = optional(bool, false)
  })
  default     = {}
  description = "Tenant flags. enable_client_connections is off so new apps don't get every connection automatically - link them explicitly via modules/connection-clients"
}
