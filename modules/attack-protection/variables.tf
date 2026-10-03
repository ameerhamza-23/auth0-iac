variable "brute_force_protection" {
  type = object({
    enabled      = optional(bool, true)
    max_attempts = optional(number, 10)
    mode         = optional(string, "count_per_identifier_and_ip")
    shields      = optional(set(string), ["block", "user_notification"])
    allowlist    = optional(set(string), [])
  })
  default     = {}
  description = "Blocks repeated failed logins against a single account"
}

variable "suspicious_ip_throttling" {
  type = object({
    enabled   = optional(bool, true)
    shields   = optional(set(string), ["admin_notification", "block"])
    allowlist = optional(set(string), [])
  })
  default     = {}
  description = "Throttles IPs that attempt too many logins across different accounts"
}

variable "breached_password_detection" {
  type = object({
    enabled = optional(bool, false)
    method  = optional(string, "standard")
    shields = optional(set(string), [])
  })
  default     = {}
  description = "Detects logins with credentials from known breaches (off by default - may need a paid plan)"
}
