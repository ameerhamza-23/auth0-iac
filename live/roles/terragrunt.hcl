include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/roles"
}

inputs = {
  roles = {
    viewer = {
      description = "Read-only access"
      permissions = [
        { name = "read:items", resource_server_identifier = "https://api.example.com" },
      ]
    }
  }
}
