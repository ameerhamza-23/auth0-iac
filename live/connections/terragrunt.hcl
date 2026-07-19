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
#
# Currently supports strategy = "auth0" (username-password, via password_policy/brute_force_protection/
# requires_username/disable_signup) and strategy = "google-oauth2" (via client_id/client_secret/scopes -
# omit client_id/client_secret to use Auth0's shared Dev Keys for testing). Other strategies need their
# own options{} fields added when actually used - see modules/connections/main.tf.
