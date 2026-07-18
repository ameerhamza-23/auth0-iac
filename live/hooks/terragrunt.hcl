# legacy - see modules/hooks/main.tf, kept for learning/comparison only
#
# hooks is a multi-instance category - do not fill in this file directly.
# Create one subdirectory per hook instead, e.g.:
#
#   live/hooks/pre-user-registration/terragrunt.hcl
#
# each with:
#
#   include "root" { path = find_in_parent_folders("root.hcl") }
#   terraform { source = "../../../modules/hooks" }
#   inputs = { name = ..., script = ..., trigger_id = ... }
#
# (source path has one extra "../" versus this file, since instances sit one directory deeper)
