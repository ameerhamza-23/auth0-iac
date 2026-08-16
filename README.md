# auth0-iac

Terraform + Terragrunt infra-as-code for an Auth0 tenant. Single environment for now.

## Status

Real and `terragrunt plan`-verified: `app`, `connections`, `connection-clients`, `actions`.
Still TODO stubs: `api`, `branding`, `prompts`, `hooks` (legacy, low priority). See each
module's `main.tf` for the exact TODO list.

## Prerequisites

- An Auth0 tenant, with a Machine-to-Machine app authorized for the Management API
  (scopes: create/read/update/delete on clients, connections; read/create/update/delete on
  client-credentials - grow the scope list as you build out more modules)
- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)

## Setup

1. Copy `.env.example` to `.env` and fill in your M2M app's credentials
   (`AUTH0_DOMAIN`, `AUTH0_CLIENT_ID`, `AUTH0_CLIENT_SECRET`), then load them into your shell.
2. Create a gitignored `local-live/` directory mirroring `live/`'s shape, but pointing
   `terraform.source` one directory level deeper (`../../../modules/...` instead of
   `../../modules/...`) and with its own `root.hcl` copy (since `find_in_parent_folders`
   only walks up, it won't cross into `live/`). This keeps the public repo a clean template
   with no real tenant data, while still letting you run and test against your own Auth0
   tenant locally.

## Usage

From your own `local-live/<category>/<instance>/` (or equivalent):

```bash
terragrunt plan
terragrunt apply
```

Or everything at once, from `local-live/`:

```bash
terragrunt run-all apply
```

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

## Contributing

Contributions welcome, especially on the TODO-stub modules (`api`, `branding`, `prompts`).

1. Fork and clone the repo.
2. Follow Setup above to get a local tenant plan running.
3. Pick a module, fill in the `TODO`s in its `main.tf`/`variables.tf`/`outputs.tf` following
   the pattern of an already-done module (e.g. `modules/connections`).
4. Add a matching `live/<category>/` entry (template shape only - no real values, no
   `terraform.tfvars`, nothing tenant-specific).
5. Verify with `terragrunt plan` against your own `local-live/` before opening a PR.
6. Open a PR describing which module/resource you filled in and what you verified.

Keep `live/` a clean template - never commit real tenant data, state files, or credentials.

## License

[MIT](LICENSE)
