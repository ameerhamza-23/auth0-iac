variable "universal_login_experience" {
  type        = string
  default     = "new"
  description = "Which Universal Login experience to use: \"new\" or \"classic\""
}

variable "identifier_first" {
  type        = bool
  default     = true
  description = "Ask for the identifier (email/username) first, then the password on a separate screen (new experience only)"
}

variable "custom_text" {
  type = map(object({
    prompt   = string
    language = string
    body     = string
  }))
  default     = {}
  description = <<-EOT
    Custom copy per prompt and language. The key is just a label; body is the JSON string, e.g.
    { login-en = { prompt = "login", language = "en", body = jsonencode({ login = { title = "Welcome" } }) } }
  EOT
}
