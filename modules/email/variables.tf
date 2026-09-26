variable "provider_name" {
  type        = string
  description = "Email provider: \"sendgrid\", \"mailgun\", \"ses\", \"smtp\", \"mandrill\", \"sparkpost\", \"ms365\", \"azure_cs\" or \"custom\""
}

variable "default_from_address" {
  type        = string
  description = "Sender address used when a template doesn't set its own"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether the provider is active"
}

# Only the credential fields for the chosen provider need to be set.

variable "api_key" {
  type        = string
  default     = null
  sensitive   = true
  description = "API key (sendgrid, mailgun, mandrill, sparkpost)"
}

variable "domain" {
  type        = string
  default     = null
  description = "Sending domain (mailgun)"
}

variable "region" {
  type        = string
  default     = null
  description = "Region (mailgun, sparkpost)"
}

variable "smtp_host" {
  type        = string
  default     = null
  description = "SMTP server hostname (smtp)"
}

variable "smtp_port" {
  type        = number
  default     = null
  description = "SMTP server port (smtp) - avoid 25"
}

variable "smtp_user" {
  type        = string
  default     = null
  description = "SMTP username (smtp)"
}

variable "smtp_pass" {
  type        = string
  default     = null
  sensitive   = true
  description = "SMTP password (smtp)"
}

variable "templates" {
  type = map(object({
    subject                 = string
    body                    = string
    from                    = optional(string)
    enabled                 = optional(bool, true)
    url_lifetime_in_seconds = optional(number)
    result_url              = optional(string)
  }))
  default     = {}
  description = "Email templates keyed by template name (e.g. \"verify_email\", \"reset_email\", \"welcome_email\"); body is Liquid HTML, typically file(\"...\")"
}
