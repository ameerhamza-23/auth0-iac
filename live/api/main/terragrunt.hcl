include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/api"
}

inputs = {
  name       = "Example API"
  identifier = "https://api.example.com"

  scopes = [
    { name = "read:items", description = "Read items" },
    { name = "write:items", description = "Create and update items" },
  ]
}
