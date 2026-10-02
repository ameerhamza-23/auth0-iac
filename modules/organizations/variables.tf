variable "name" {
  type        = string
  description = "Organization name: lowercase, no spaces (immutable - changing it recreates the resource)"
}

variable "display_name" {
  type        = string
  default     = null
  description = "Friendly name shown to users"
}

variable "metadata" {
  type        = map(string)
  default     = {}
  description = "Up to 10 key/value pairs attached to the organization"
}

variable "logo_url" {
  type        = string
  default     = null
  description = "Logo shown on this organization's login pages"
}

variable "colors" {
  type        = map(string)
  default     = null
  description = "Login page colors, e.g. { primary = \"#0059d6\", page_background = \"#000000\" }"
}

variable "connections" {
  type = list(object({
    connection_id              = string
    assign_membership_on_login = optional(bool, false)
    show_as_button             = optional(bool, false)
  }))
  default     = []
  description = "Connections enabled for this organization"
}

variable "client_ids" {
  type        = list(string)
  default     = []
  description = "Applications that can sign in members of this organization"
}
