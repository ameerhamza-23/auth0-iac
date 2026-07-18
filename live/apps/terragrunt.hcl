include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/app"
}

inputs = {
  name                   = "my-first-app"
  app_type               = "regular_web"
  callbacks              = ["http://localhost:3000/callback"]
  allowed_logout_urls    = ["http://localhost:3000"]
  authentication_method  = "client_secret_post"
}
