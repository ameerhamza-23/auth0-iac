# event-streams is a multi-instance category - do not fill in this file directly.
# Create one subdirectory per event stream instead, e.g.:
#
#   live/event-streams/user-events-webhook/terragrunt.hcl
#
# each with (webhook destination):
#
#   include "root" { path = find_in_parent_folders("root.hcl") }
#   terraform { source = "../../../modules/event-streams" }
#   inputs = {
#     name             = "user-events"
#     destination_type = "webhook"
#     subscriptions    = ["user.created", "user.updated"]
#     webhook_endpoint = "https://events.example.com/auth0"
#     webhook_auth     = { method = "bearer", token = get_env("EVENTS_WEBHOOK_TOKEN") }
#   }
#
# or an action destination, wired to an action from live/actions:
#
#   dependency "handler" { config_path = "../../actions/<action-name>" }
#   inputs = {
#     name             = "user-events"
#     destination_type = "action"
#     subscriptions    = ["user.created"]
#     action_id        = dependency.handler.outputs.action_id
#   }
#
# or destination_type = "eventbridge" with eventbridge = { aws_account_id = ..., aws_region = ... }.
#
# (source path has one extra "../" versus this file, since instances sit one directory deeper;
#  dependency config_path is relative to the instance's own directory)
