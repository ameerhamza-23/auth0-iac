include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/tenant"
}

inputs = {
  friendly_name = "Example Tenant"
  support_email = "support@example.com"
}
