include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/guardian"
}

inputs = {
  policy = "all-applications"
  otp    = true
}
