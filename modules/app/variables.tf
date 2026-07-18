variable "name" {
  type        = string
  description = "Display name of the Auth0 application"
}

variable "app_type" {
  type        = string
  description = "Auth0 application type, e.g. \"regular_web\" or \"spa\""
}

variable "callbacks" {
  type        = list(string)
  description = "URLs Auth0 may redirect to after login"
}

variable "allowed_logout_urls" {
  type        = list(string)
  description = "URLs Auth0 may redirect to after logout"
}

variable "authentication_method" {
  type        = string
  description = "How this client authenticates to Auth0, e.g. \"client_secret_post\" (regular_web) or \"none\" (public clients like spa)"
}
