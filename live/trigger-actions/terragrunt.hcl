# trigger-actions is a multi-instance category (one per trigger) - do not fill in this file directly.
# Create one subdirectory per trigger instead, e.g.:
#
#   live/trigger-actions/post-login/terragrunt.hcl
#
# each with:
#
#   include "root" { path = find_in_parent_folders("root.hcl") }
#   terraform { source = "../../../modules/trigger-actions" }
#   dependency "first"  { config_path = "../../actions/<first-action>" }
#   dependency "second" { config_path = "../../actions/<second-action>" }
#   inputs = {
#     trigger = "post-login"
#     actions = [
#       { id = dependency.first.outputs.action_id,  display_name = "first" },
#       { id = dependency.second.outputs.action_id, display_name = "second" },
#     ]
#   }
#
# and set bind_trigger = false in each of those actions' own inputs.
