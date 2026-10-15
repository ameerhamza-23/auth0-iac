resource "auth0_event_stream" "this" {
  name             = var.name
  destination_type = var.destination_type
  subscriptions    = var.subscriptions
  status           = var.status

  dynamic "webhook_configuration" {
    for_each = var.destination_type == "webhook" ? [1] : []
    content {
      webhook_endpoint = var.webhook_endpoint

      webhook_authorization {
        method   = var.webhook_auth.method
        username = var.webhook_auth.username

        # The provider wants each write-only value and its version set together, so only send the pair
        # for the chosen method.
        password_wo         = var.webhook_auth.method == "basic" ? var.webhook_auth.password : null
        password_wo_version = var.webhook_auth.method == "basic" ? var.webhook_auth_version : null
        token_wo            = var.webhook_auth.method == "bearer" ? var.webhook_auth.token : null
        token_wo_version    = var.webhook_auth.method == "bearer" ? var.webhook_auth_version : null
      }
    }
  }

  dynamic "eventbridge_configuration" {
    for_each = var.destination_type == "eventbridge" ? [1] : []
    content {
      aws_account_id = var.eventbridge.aws_account_id
      aws_region     = var.eventbridge.aws_region
    }
  }

  dynamic "action_configuration" {
    for_each = var.destination_type == "action" ? [1] : []
    content {
      action_id = var.action_id
    }
  }

  lifecycle {
    precondition {
      condition     = var.destination_type != "webhook" || (var.webhook_endpoint != null && var.webhook_auth != null)
      error_message = "destination_type = webhook requires webhook_endpoint and webhook_auth."
    }
    precondition {
      condition     = var.destination_type != "eventbridge" || var.eventbridge != null
      error_message = "destination_type = eventbridge requires eventbridge."
    }
    precondition {
      condition     = var.destination_type != "action" || var.action_id != null
      error_message = "destination_type = action requires action_id."
    }
  }
}
