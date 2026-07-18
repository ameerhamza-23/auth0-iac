variable "name" {
  type        = string
  description = "Name of the connection (immutable - changing it recreates the resource)"
}

variable "strategy" {
  type        = string
  description = "Identity provider type, e.g. \"auth0\" for username-password"
}

variable "password_policy" {
  type        = string
  description = "One of \"none\", \"low\", \"fair\", \"good\", \"excellent\""
}

variable "brute_force_protection" {
  type        = bool
  description = "Limit signups/failed logins from a suspicious IP"
}

variable "requires_username" {
  type        = bool
  description = "Whether users must set a username in addition to email"
}

variable "disable_signup" {
  type        = bool
  description = "If true, only users created out-of-band (e.g. via Management API) can log in - no public signup"
}
