# auth0-iac

Terraform + Terragrunt infra-as-code for an Auth0 tenant. Single environment for now.

## Structure

```
modules/                    # reusable Terraform, never applied directly
  auth0-app/                  # auth0_client + auth0_client_grant
  auth0-connections/            # auth0_connection (username-password, social, etc.)
  auth0-connection-clients/       # auth0_connection_client - links an app to a connection

live/                        # applied units, one Terragrunt run per subfolder
  apps/                        # calls modules/auth0-app
  connections/                   # calls modules/auth0-connections
  connection-clients/              # calls modules/auth0-connection-clients, depends on apps + connections

terragrunt.hcl               # root - backend + provider generation, shared by every unit under live/
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
