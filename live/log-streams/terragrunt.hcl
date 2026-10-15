# log-streams is a multi-instance category - do not fill in this file directly.
# Create one subdirectory per log stream instead, e.g.:
#
#   live/log-streams/datadog/terragrunt.hcl
#   live/log-streams/siem-webhook/terragrunt.hcl
#
# each with:
#
#   include "root" { path = find_in_parent_folders("root.hcl") }
#   terraform { source = "../../../modules/log-streams" }
#   inputs = {
#     name = "siem-webhook"
#     type = "http"
#     sink = {
#       http_endpoint       = "https://logs.example.com/auth0"
#       http_content_format = "JSONARRAY"
#       http_content_type   = "application/json"
#     }
#     sink_secrets = { http_authorization = get_env("SIEM_TOKEN") }
#     filters      = [{ type = "category", name = "auth.login.fail" }]
#   }
#
# (source path has one extra "../" versus this file, since instances sit one directory deeper)
#
# type is one of: eventbridge, eventgrid, http, datadog, splunk, sumo, segment, mixpanel. Only set the
# sink fields that type uses (see modules/log-streams/variables.tf). Keep credentials in sink_secrets,
# read from the environment rather than written into the file.
