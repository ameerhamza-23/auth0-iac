variable "name" {
  type        = string
  description = "Name of the action"
}

variable "code" {
  type        = string
  description = "The action's Node.js source code, typically loaded via file(\"...\")"
}

variable "trigger" {
  type        = string
  description = "Trigger to bind this action to, e.g. \"post-login\""
}

variable "dependencies" {
  type = list(object({
    name    = string
    version = string
  }))
  default     = []
  description = "npm packages the action's code depends on"
}

variable "secrets" {
  type = list(object({
    name  = string
    value = string
  }))
  default     = []
  sensitive   = true
  description = "Secrets available to the action's code as event.secrets.<name> - stored write-only, never in state"
}

variable "secrets_wo_version" {
  type        = number
  default     = 1
  description = "Bump this to force Auth0 to pick up changed secret values (write-only secrets aren't diffed automatically)"
}
