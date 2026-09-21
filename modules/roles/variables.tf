variable "roles" {
  type = map(object({
    description = optional(string)
    permissions = optional(list(object({
      name                       = string
      resource_server_identifier = string
    })), [])
  }))
  description = "Roles to create, keyed by role name, each with the API permissions it grants"
}
