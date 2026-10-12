resource "auth0_action" "this" {
  name    = var.name
  runtime = "node22"
  deploy  = true
  code    = var.code

  supported_triggers {
    id      = var.trigger
    version = "v3"
  }

  dynamic "dependencies" {
    for_each = var.dependencies
    content {
      name    = dependencies.value.name
      version = dependencies.value.version
    }
  }

  # write-only secrets - never stored in Terraform state, unlike the plain `secrets` block.
  # Bump secrets_wo_version to force Auth0 to pick up a changed value.
  dynamic "secrets_wo" {
    for_each = var.secrets
    content {
      name  = secrets_wo.value.name
      value = secrets_wo.value.value
    }
  }
  secrets_wo_version = var.secrets_wo_version
}

# One action per trigger only. To run several actions on the same trigger in a defined order, set
# bind_trigger = false on each and bind them together with modules/trigger-actions instead -
# both resources managing the same trigger would overwrite each other.
resource "auth0_trigger_action" "this" {
  count = var.bind_trigger ? 1 : 0

  trigger   = var.trigger
  action_id = auth0_action.this.id
}

moved {
  from = auth0_trigger_action.this
  to   = auth0_trigger_action.this[0]
}
