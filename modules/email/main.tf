# Without a custom provider Auth0 sends from its shared, rate-limited default - fine for testing only.
resource "auth0_email_provider" "this" {
  name                 = var.provider_name
  enabled              = var.enabled
  default_from_address = var.default_from_address

  credentials {
    api_key   = var.api_key
    domain    = var.domain
    region    = var.region
    smtp_host = var.smtp_host
    smtp_port = var.smtp_port
    smtp_user = var.smtp_user
    smtp_pass = var.smtp_pass
  }
}

# Each template needs the email provider configured first.
resource "auth0_email_template" "this" {
  for_each = var.templates

  template = each.key
  syntax   = "liquid"
  enabled  = each.value.enabled
  from     = each.value.from
  subject  = each.value.subject
  body     = each.value.body

  url_lifetime_in_seconds = each.value.url_lifetime_in_seconds
  result_url              = each.value.result_url

  depends_on = [auth0_email_provider.this]
}
