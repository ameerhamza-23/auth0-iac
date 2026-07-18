# api is a multi-instance category - do not fill in this file directly.
# Create one subdirectory per API instance instead, e.g.:
#
#   live/api/main/terragrunt.hcl
#
# each with:
#
#   include "root" { path = find_in_parent_folders("root.hcl") }
#   terraform { source = "../../../modules/api" }
#   inputs = { name = ..., identifier = ..., scopes = [...] }
#
# (source path has one extra "../" versus this file, since instances sit one directory deeper)
