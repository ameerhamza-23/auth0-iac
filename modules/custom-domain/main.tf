resource "auth0_custom_domain" "this" {
  domain                  = var.domain
  type                    = var.type
  tls_policy              = var.tls_policy
  custom_client_ip_header = var.custom_client_ip_header
}

# Waits for Auth0 to verify the DNS record, so create the record from the verification_methods
# output first - apply fails on timeout otherwise.
resource "auth0_custom_domain_verification" "this" {
  count = var.verify ? 1 : 0

  custom_domain_id = auth0_custom_domain.this.id

  timeouts {
    create = var.verification_timeout
  }
}
