resource "auth0_prompt" "this" {
  universal_login_experience = var.universal_login_experience
  identifier_first           = var.identifier_first
}

# One resource per prompt/language pair, keyed by the caller's map key.
resource "auth0_prompt_custom_text" "this" {
  for_each = var.custom_text

  prompt   = each.value.prompt
  language = each.value.language
  body     = each.value.body
}
