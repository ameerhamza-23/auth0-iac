# connections is a multi-instance category - do not fill in this file directly.
# Create one subdirectory per connection instance instead, e.g.:
#
#   live/connections/username-password/terragrunt.hcl
#   live/connections/google/terragrunt.hcl
#
# each with:
#
#   include "root" { path = find_in_parent_folders("root.hcl") }
#   terraform { source = "../../../modules/connections" }
#   inputs = { name = ..., strategy = ... }
#
# (source path has one extra "../" versus this file, since instances sit one directory deeper)
