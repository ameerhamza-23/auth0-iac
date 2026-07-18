# actions is a multi-instance category - do not fill in this file directly.
# Create one subdirectory per action instead, e.g.:
#
#   live/actions/post-login-enrichment/terragrunt.hcl
#
# each with:
#
#   include "root" { path = find_in_parent_folders("root.hcl") }
#   terraform { source = "../../../modules/actions" }
#   inputs = { name = ..., code = file("...")..., trigger = ... }
#
# (source path has one extra "../" versus this file, since instances sit one directory deeper)
