# organizations is a multi-instance category - do not fill in this file directly.
# Create one subdirectory per organization instead, e.g.:
#
#   live/organizations/acme/terragrunt.hcl
#
# each with:
#
#   include "root" { path = find_in_parent_folders("root.hcl") }
#   terraform { source = "../../../modules/organizations" }
#   dependency "connection" { config_path = "../../connections/<connection-name>" }
#   dependency "app"        { config_path = "../../apps/<app-name>" }
#   inputs = {
#     name         = "acme"
#     display_name = "Acme Inc"
#     connections  = [{ connection_id = dependency.connection.outputs.connection_id }]
#     client_ids   = [dependency.app.outputs.client_id]
#   }
#
# (source path has one extra "../" versus this file, since instances sit one directory deeper;
#  dependency config_path is relative to the instance's own directory)
