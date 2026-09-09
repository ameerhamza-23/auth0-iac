variable "name" {
  type        = string
  description = "Name of the hook"
}

variable "script" {
  type        = string
  description = "Hook code, typically loaded via file(\"...\")"
}

variable "trigger_id" {
  type        = string
  description = "Execution stage: credentials-exchange, pre-user-registration, post-user-registration, post-change-password or send-phone-message"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether the hook runs"
}

variable "dependencies" {
  type        = map(string)
  default     = {}
  description = "npm packages the hook needs, as name => version"
}

variable "secrets" {
  type        = map(string)
  default     = {}
  sensitive   = true
  description = "Secrets available to the hook as context.webtask.secrets.<name> (stored in state)"
}
