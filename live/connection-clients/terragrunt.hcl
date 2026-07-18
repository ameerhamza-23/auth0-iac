# connection-clients is a multi-instance category - do not fill in this file directly.
# Structure: <connection-name>/<app-name>/terragrunt.hcl - groups by connection first, so every
# app linked to a given connection is visible together, e.g.:
#
#   live/connection-clients/username-password/web/terragrunt.hcl
#   live/connection-clients/username-password/mobile/terragrunt.hcl   (another app, same connection)
#   live/connection-clients/google/web/terragrunt.hcl                 (same app, another connection)
#
# each with:
#
#   include "root" { path = find_in_parent_folders("root.hcl") }
#   terraform { source = "../../../../modules/connection-clients" }
#   dependency "app" {
#     config_path = "../../../apps/<app-name>"
#   }
#   dependency "connection" {
#     config_path = "../../../connections/<connection-name>"
#   }
#   inputs = {
#     client_id     = dependency.app.outputs.client_id
#     connection_id = dependency.connection.outputs.connection_id
#   }
#
# (source path has two extra "../" versus this file, since instances sit two directories deeper;
#  dependency config_path is relative to this file's own directory)
