# auth0-iac

Terraform + Terragrunt infra-as-code for an Auth0 tenant. Single environment for now.

## Status

All 18 modules are implemented and pass `terraform validate` (CI runs `fmt -check` and `validate` on every
push). `connections` only covers username-password (`auth0`) and `google-oauth2`; other strategies need
their own `options{}` fields added. `hooks` is legacy (deprecated by Auth0) and kept for comparison only.
`connection-clients` uses the per-link `auth0_connection_client` resource - don't mix it with
`auth0_connection_clients` (the whole-set variant) on the same connection, since that overwrites links.

`log-streams` and `event-streams` keep destination credentials in separate sensitive inputs. Only the Datadog
API key and webhook credentials are stored write-only; other log stream credentials end up in state.

`trigger-actions` orders several actions on one trigger; set `bind_trigger = false` on those actions in
`modules/actions` so the two don't overwrite each other.

State is local (`live/root.hcl`); switch the backend to remote storage before sharing this with anyone.

## Prerequisites

- An Auth0 tenant, with a Machine-to-Machine app authorized for the Management API. Grant it the scopes
  for the modules you use:
  - `app`: `create|read|update|delete:clients`, `read|update:client_keys`, `create|read|update|delete:client_grants`
  - `connections`, `connection-clients`: `create|read|update|delete:connections`, `read|update:clients`
  - `api`: `create|read|update|delete:resource_servers`
  - `actions`: `create|read|update|delete:actions`
  - `branding`: `read|update:branding`, plus `read|update:page_templates` for custom login HTML
  - `prompts`: `read|update:prompts`
  - `hooks` (legacy): `create|read|update|delete:hooks`
  - `tenant`: `read|update:tenant_settings`
  - `roles`: `create|read|update|delete:roles`, `read:resource_servers`
  - `custom-domain`: `create|read|update|delete:custom_domains`
  - `email`: `read|update:email_provider`, `create|read|update:email_templates`
  - `organizations`: `create|read|update|delete:organizations`, `read|create|update|delete:organization_connections`
  - `attack-protection`: `read|update:attack_protection`
  - `guardian`: `read|update:guardian_factors`, `read|update:mfa_policies`
  - `log-streams`: `create|read|update|delete:log_streams`
  - `event-streams`: `create|read|update|delete:event_streams`
- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.11 (write-only action secrets)
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
  trigger-actions/                          # auth0_trigger_actions - several actions on one trigger, in order
  tenant/                                     # auth0_tenant - sessions, locales, flags (singleton)
  roles/                                        # auth0_role + role permissions (RBAC)
  custom-domain/                                  # auth0_custom_domain + DNS verification
  email/                                            # auth0_email_provider + email templates
  organizations/                                      # auth0_organization + connections/clients (B2B)
  attack-protection/                                    # brute force, suspicious IP, breached passwords (singleton)
  guardian/                                               # MFA policy and factors (singleton)
  log-streams/                                              # auth0_log_stream - forward tenant logs to a SIEM or monitoring tool
  event-streams/                                              # auth0_event_stream - deliver tenant events to a webhook, EventBridge or action

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
  trigger-actions/                                      # multi-instance category (one per trigger)
  organizations/                                          # multi-instance category
  log-streams/                                              # multi-instance category (one per destination)
  event-streams/                                              # multi-instance category (one per destination)
  tenant/, roles/, custom-domain/, email/, attack-protection/, guardian/   # singletons
```

Multi-instance categories (`apps`, `connections`, `connection-clients`, `api`, `actions`, `hooks`, `log-streams`, `event-streams`)
don't hold a runnable unit directly - each one's `terragrunt.hcl` is a comment explaining the
subdirectory pattern (e.g. `live/apps/web/terragrunt.hcl`) since each real instance needs its own
Terragrunt run and state file. Singletons (`branding`, `prompts`) are flat, since only one instance
of those will ever exist per tenant.

## Contributing

Contributions welcome, e.g. more connection strategies, or Auth0 resources that don't have a module yet.

1. Fork and clone the repo.
2. Follow Setup above to get a local tenant plan running.
3. Pick a module (or add a new one) and extend its `main.tf`/`variables.tf`/`outputs.tf`
   following the pattern of an existing module (e.g. `modules/connections`).
4. Add a matching `live/<category>/` entry (template shape only - no real values, no
   `terraform.tfvars`, nothing tenant-specific).
5. Verify with `terragrunt plan` against your own `local-live/` before opening a PR.
6. Open a PR describing which module/resource you filled in and what you verified.

Keep `live/` a clean template - never commit real tenant data, state files, or credentials.

## License

[MIT](LICENSE)
