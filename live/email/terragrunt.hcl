include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/email"
}

inputs = {
  provider_name        = "sendgrid"
  default_from_address = "no-reply@example.com"
  # api_key comes from the environment, never from this file:  export TF_VAR_api_key=...

  templates = {
    welcome_email = {
      subject = "Welcome to Example"
      body    = file("${get_terragrunt_dir()}/welcome.html")
    }
  }
}
