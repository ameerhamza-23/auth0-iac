# auth0-iac

Terraform + Terragrunt infra-as-code for an Auth0 tenant. Single environment for now.

## Structure

```
modules/                    # reusable Terraform, never applied directly
  app/                         # auth0_client + auth0_client_credentials
  connections/                   # auth0_connection (username-password, social, etc.)
  connection-clients/              # auth0_connection_client - links an app to a connection
  api/                            # auth0_resource_server + scopes
  branding/                         # auth0_branding, theme, custom pages
  prompts/                            # universal login prompt config + custom text
  actions/                              # auth0_action + trigger binding
  hooks/                                  # legacy, kept for learning/comparison - see modules/hooks/main.tf

live/                        # the SHAPE only - no real values, this is a template, not a deployment
  root.hcl                      # shared backend + provider generation for everything under live/
  apps/                            # multi-instance category - see the comment in its terragrunt.hcl
  connections/                       # multi-instance category
  connection-clients/                  # multi-instance category
  api/                                    # multi-instance category
  branding/                                  # singleton - one instance per tenant
  prompts/                                      # singleton
  actions/                                         # multi-instance category
  hooks/                                              # multi-instance category, legacy
```

Multi-instance categories (`apps`, `connections`, `connection-clients`, `api`, `actions`, `hooks`)
don't hold a runnable unit directly - each one's `terragrunt.hcl` is a comment explaining the
subdirectory pattern (e.g. `live/apps/web/terragrunt.hcl`) since each real instance needs its own
Terragrunt run and state file. Singletons (`branding`, `prompts`) are flat, since only one instance
of those will ever exist per tenant.

To actually deploy something, create your own equivalent of `live/` with real values - e.g. a
gitignored `local-live/` sibling directory, mirroring `live/`'s shape but pointing `terraform.source`
one directory level deeper (`../../../modules/...` instead of `../../modules/...`) and with its own
`root.hcl` copy (since `find_in_parent_folders` only walks up, it won't cross into `live/`). This
keeps the public repo a clean template with no real tenant data, while still letting you run and test
against your own Auth0 tenant locally.

## Prereqs

- Auth0 tenant, with a Machine-to-Machine app authorized for the Management API
  (scopes: create/read/update/delete on clients, connections; read/create/update/delete on
  client-credentials - grow the scope list as you build out more modules)
- `terraform`, `terragrunt` installed
- Env vars set: `AUTH0_DOMAIN`, `AUTH0_CLIENT_ID`, `AUTH0_CLIENT_SECRET` (the M2M app's creds) -
  see `.env.example`

## Running a unit

From your own `local-live/<category>/<instance>/` (or equivalent):

```bash
terragrunt plan
terragrunt apply
```

Or everything at once, from `local-live/`:

```bash
terragrunt run-all apply
```

## Status

`modules/app` is real and `terragrunt plan`-verified. Everything else is still a TODO stub. Filling
in as I learn Terraform/Terragrunt.
