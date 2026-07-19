variable "name" {
  type        = string
  description = "Name of the connection (immutable - changing it recreates the resource)"
}

variable "strategy" {
  type        = string
  description = "Identity provider type, e.g. \"auth0\" for username-password, \"google-oauth2\" for Google"
}

# username-password (strategy = "auth0")

variable "password_policy" {
  type        = string
  default     = null
  description = "One of \"none\", \"low\", \"fair\", \"good\", \"excellent\""
}

variable "brute_force_protection" {
  type        = bool
  default     = null
  description = "Limit signups/failed logins from a suspicious IP"
}

variable "requires_username" {
  type        = bool
  default     = null
  description = "Whether users must set a username in addition to email"
}

variable "disable_signup" {
  type        = bool
  default     = null
  description = "If true, only users created out-of-band (e.g. via Management API) can log in - no public signup"
}

# google-oauth2 (and other client-id/secret-based social strategies)

variable "client_id" {
  type        = string
  default     = null
  description = "OAuth client ID from the identity provider (e.g. Google Cloud Console). Omit for google-oauth2 to use Auth0's shared Dev Keys."
}

variable "client_secret" {
  type        = string
  default     = null
  sensitive   = true
  description = "OAuth client secret from the identity provider. Omit for google-oauth2 to use Auth0's shared Dev Keys."
}

variable "scopes" {
  type        = list(string)
  default     = null
  description = "Permissions to request from the identity provider, e.g. [\"email\", \"profile\"] for Google"
}
