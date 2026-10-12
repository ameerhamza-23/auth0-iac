# Binds an ordered list of actions to one trigger. The list order is the execution order.
# Actions bound here must have bind_trigger = false in modules/actions.
resource "auth0_trigger_actions" "this" {
  trigger = var.trigger

  dynamic "actions" {
    for_each = var.actions
    content {
      id           = actions.value.id
      display_name = actions.value.display_name
    }
  }
}
