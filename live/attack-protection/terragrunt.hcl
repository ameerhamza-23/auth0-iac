include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/attack-protection"
}

inputs = {
  brute_force_protection = {
    max_attempts = 5
  }
}
