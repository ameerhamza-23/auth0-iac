include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/prompts"
}

inputs = {
  identifier_first = true

  custom_text = {
    login-en = {
      prompt   = "login"
      language = "en"
      body     = jsonencode({ login = { title = "Welcome back" } })
    }
  }
}
