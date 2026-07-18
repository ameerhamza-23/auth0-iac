# connection-clients is a multi-instance category - do not fill in this file directly.
# Create one subdirectory per (connection, app) pair instead, e.g.:
#
#   live/connection-clients/web-username-password/terragrunt.hcl
#
# each with:
#
#   include "root" { path = find_in_parent_folders("root.hcl") }
#   terraform { source = "../../../modules/connection-clients" }
#   dependency "app" {
#     config_path = "../../apps/web"
#   }
#   dependency "connection" {
#     config_path = "../../connections/username-password"
#   }
#   inputs = {
#     client_id     = dependency.app.outputs.client_id
#     connection_id = dependency.connection.outputs.connection_id
#   }
#
# (source path has one extra "../" versus this file, since instances sit one directory deeper;
#  dependency config_path is relative to this file's own directory)
