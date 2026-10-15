variable "name" {
  type        = string
  description = "Name of the log stream"
}

variable "type" {
  type        = string
  description = "Sink type: eventbridge, eventgrid, http, datadog, splunk, sumo, segment or mixpanel (immutable - changing it recreates the stream)"

  validation {
    condition     = contains(["eventbridge", "eventgrid", "http", "datadog", "splunk", "sumo", "segment", "mixpanel"], var.type)
    error_message = "type must be one of: eventbridge, eventgrid, http, datadog, splunk, sumo, segment, mixpanel."
  }
}

variable "status" {
  type        = string
  default     = null
  description = "active, paused or suspended. Leave unset to keep Auth0's default (active)"
}

variable "is_priority" {
  type        = bool
  default     = null
  description = "Send this stream's events ahead of non-priority streams"
}

variable "filters" {
  type        = list(map(string))
  default     = null
  description = "Only forward matching log events, e.g. [{ type = \"category\", name = \"auth.login.fail\" }]"
}

variable "pii_config" {
  type = object({
    log_fields = list(string)
    method     = optional(string)
    algorithm  = optional(string)
  })
  default     = null
  description = "Hash or mask these log fields before they leave Auth0, e.g. { log_fields = [\"first_name\", \"last_name\"], method = \"hash\" }"
}

variable "sink" {
  type = object({
    # eventbridge
    aws_account_id = optional(string)
    aws_region     = optional(string)
    # eventgrid
    azure_subscription_id = optional(string)
    azure_region          = optional(string)
    azure_resource_group  = optional(string)
    # http
    http_endpoint       = optional(string)
    http_content_format = optional(string)
    http_content_type   = optional(string)
    http_custom_headers = optional(list(map(string)))
    # datadog
    datadog_region = optional(string)
    # splunk
    splunk_domain = optional(string)
    splunk_port   = optional(string)
    splunk_secure = optional(bool)
    # sumo
    sumo_source_address = optional(string)
    # mixpanel
    mixpanel_project_id               = optional(string)
    mixpanel_region                   = optional(string)
    mixpanel_service_account_username = optional(string)
  })
  default     = {}
  description = "Non-secret destination settings for the chosen type. Only set the fields that type uses"
}

variable "sink_secrets" {
  type = object({
    datadog_api_key                   = optional(string)
    http_authorization                = optional(string)
    mixpanel_service_account_password = optional(string)
    segment_write_key                 = optional(string)
    splunk_token                      = optional(string)
  })
  default     = {}
  sensitive   = true
  description = "Destination credentials. Only datadog_api_key is stored write-only; the others are saved in Terraform state, so keep state private"
}

variable "datadog_api_key_version" {
  type        = number
  default     = 1
  description = "Bump this to force Auth0 to pick up a changed datadog_api_key (write-only values aren't diffed automatically)"
}
