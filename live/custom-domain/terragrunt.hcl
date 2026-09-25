include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/custom-domain"
}

inputs = {
  domain = "login.example.com"
  # First apply with verify = false, create the DNS record from the verification_methods output,
  # then set verify = true and apply again.
  verify = false
}
