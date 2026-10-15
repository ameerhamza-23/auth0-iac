variable "name" {
  type        = string
  description = "Name of the event stream"
}

variable "destination_type" {
  type        = string
  description = "Where events are delivered: webhook, eventbridge or action (immutable - changing it recreates the stream)"

  validation {
    condition     = contains(["webhook", "eventbridge", "action"], var.destination_type)
    error_message = "destination_type must be one of: webhook, eventbridge, action."
  }
}

variable "subscriptions" {
  type        = list(string)
  description = "Event types to deliver, e.g. [\"user.created\", \"user.updated\"]"
}

variable "status" {
  type        = string
  default     = null
  description = "Leave unset to keep Auth0's default. Set to disabled to pause delivery"
}

variable "webhook_endpoint" {
  type        = string
  default     = null
  description = "HTTPS URL that receives events. Required when destination_type = webhook"
}

variable "webhook_auth" {
  type = object({
    method   = string
    username = optional(string)
    password = optional(string)
    token    = optional(string)
  })
  default     = null
  sensitive   = true
  description = "How Auth0 authenticates to the webhook: method \"basic\" (username + password) or \"bearer\" (token). Credentials are stored write-only"
}

variable "webhook_auth_version" {
  type        = number
  default     = 1
  description = "Bump this to force Auth0 to pick up changed webhook credentials (write-only values aren't diffed automatically)"
}

variable "eventbridge" {
  type = object({
    aws_account_id = string
    aws_region     = string
  })
  default     = null
  description = "AWS account and region for the partner event source. Required when destination_type = eventbridge"
}

variable "action_id" {
  type        = string
  default     = null
  description = "Action that receives events, typically modules/actions' action_id output. Required when destination_type = action"
}
