# apps is a multi-instance category - do not fill in this file directly.
# Create one subdirectory per app instance instead, e.g.:
#
#   live/apps/web/terragrunt.hcl
#
# each with:
#
#   include "root" { path = find_in_parent_folders("root.hcl") }
#   terraform { source = "../../../modules/app" }
#   inputs = { name = ..., app_type = ..., callbacks = [...], allowed_logout_urls = [...], authentication_method = ... }
#
# (source path has one extra "../" versus this file, since instances sit one directory deeper)
#
# Also supports M2M apps (app_type = "non_interactive") - leave callbacks/allowed_logout_urls unset,
# set audience + scopes instead to create an auth0_client_grant against an API (e.g. the Management API).
