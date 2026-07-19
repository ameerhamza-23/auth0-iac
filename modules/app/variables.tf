variable "name" {
  type        = string
  description = "Display name of the Auth0 application"
}

variable "app_type" {
  type        = string
  description = "Auth0 application type, e.g. \"regular_web\", \"spa\", or \"non_interactive\" for M2M"
}

variable "callbacks" {
  type        = list(string)
  default     = null
  description = "URLs Auth0 may redirect to after login (login apps only, not applicable to M2M)"
}

variable "allowed_logout_urls" {
  type        = list(string)
  default     = null
  description = "URLs Auth0 may redirect to after logout (login apps only, not applicable to M2M)"
}

variable "authentication_method" {
  type        = string
  description = "How this client authenticates to Auth0, e.g. \"client_secret_post\" (regular_web/M2M) or \"none\" (public clients like spa)"
}

variable "audience" {
  type        = string
  default     = null
  description = "API identifier to grant this client access to (M2M only) - set this to create an auth0_client_grant, leave null for login apps"
}

variable "scopes" {
  type        = list(string)
  default     = null
  description = "Scopes to grant against audience (M2M only, requires audience to be set)"
}
