# auth0-iac

Terraform + Terragrunt infra-as-code for an Auth0 tenant. Single environment for now.

## Structure

```
modules/                    # reusable Terraform, never applied directly
  app/                         # auth0_client + auth0_client_grant
  connections/                   # auth0_connection (username-password, social, etc.)
  connection-clients/              # auth0_connection_client - links an app to a connection
  api/                            # auth0_resource_server + scopes
  branding/                         # auth0_branding, theme, custom pages
  prompts/                            # universal login prompt config + custom text
  actions/                              # auth0_action + trigger binding
  hooks/                                  # legacy, kept for learning/comparison - see modules/hooks/main.tf

live/                        # applied units, one Terragrunt run per subfolder
  terragrunt.hcl                # root for this tree - backend + provider generation, shared via include
  apps/                        # calls modules/app
  connections/                   # calls modules/connections
  connection-clients/              # calls modules/connection-clients, depends on apps + connections
  api/                                # calls modules/api
  branding/                             # calls modules/branding
  prompts/                                # calls modules/prompts
  actions/                                  # calls modules/actions
  hooks/                                      # calls modules/hooks
```

## Prereqs

- Auth0 tenant, with a Machine-to-Machine app authorized for the Management API
  (scopes: create/read/update/delete on clients, connections, client-grants)
- `terraform`, `terragrunt` installed
- Env vars set: `AUTH0_DOMAIN`, `AUTH0_CLIENT_ID`, `AUTH0_CLIENT_SECRET` (the M2M app's creds)

## Running a unit

```bash
cd live/apps
terragrunt apply
```

Or everything at once:

```bash
cd live
terragrunt run-all apply
```

## Status

Skeleton only - modules and live units are TODO stubs. Filling in as I learn Terraform/Terragrunt.
