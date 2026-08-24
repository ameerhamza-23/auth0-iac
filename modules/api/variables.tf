variable "name" {
  type        = string
  description = "Friendly name of the API (cannot contain < or >)"
}

variable "identifier" {
  type        = string
  description = "Unique API identifier, used as the `audience` in authorization calls (immutable - changing it recreates the API)"
}

variable "scopes" {
  type = list(object({
    name        = string
    description = optional(string)
  }))
  default     = []
  description = "Scopes (permissions) this API exposes, e.g. { name = \"read:orders\", description = \"Read orders\" }"
}

variable "signing_alg" {
  type        = string
  default     = "RS256"
  description = "Algorithm used to sign access tokens: \"RS256\", \"PS256\" or \"HS256\""
}

variable "token_lifetime" {
  type        = number
  default     = 86400
  description = "Seconds an access token issued for this API stays valid"
}

variable "allow_offline_access" {
  type        = bool
  default     = false
  description = "Whether refresh tokens can be issued for this API"
}

variable "enforce_policies" {
  type        = bool
  default     = false
  description = "Enforce RBAC: only permissions assigned to the user via roles are included in the token"
}

variable "token_dialect" {
  type        = string
  default     = "access_token"
  description = "Access token format: \"access_token\" or \"access_token_authz\" (adds a permissions claim, needs enforce_policies)"
}

variable "skip_consent_for_verifiable_first_party_clients" {
  type        = bool
  default     = true
  description = "Skip the consent prompt for first-party applications"
}
