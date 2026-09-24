variable "domain" {
  type        = string
  description = "Custom domain name, e.g. \"login.example.com\" (immutable - changing it recreates the resource)"
}

variable "type" {
  type        = string
  default     = "auth0_managed_certs"
  description = "\"auth0_managed_certs\" (Auth0 provisions the certificate) or \"self_managed_certs\""
}

variable "tls_policy" {
  type        = string
  default     = "recommended"
  description = "\"recommended\" (TLS 1.2+) or \"compatible\" (allows TLS 1.0/1.1)"
}

variable "custom_client_ip_header" {
  type        = string
  default     = null
  description = "Header carrying the client IP (self_managed_certs only), e.g. \"cf-connecting-ip\""
}

variable "verify" {
  type        = bool
  default     = false
  description = "Also run auth0_custom_domain_verification. Leave false on the first apply, add the DNS record, then set true"
}

variable "verification_timeout" {
  type        = string
  default     = "10m"
  description = "How long to wait for DNS verification to succeed"
}
