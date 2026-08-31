include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/branding"
}

inputs = {
  logo_url              = "https://example.com/logo.png"
  primary_color         = "#0059d6"
  page_background_color = "#000000"
}
