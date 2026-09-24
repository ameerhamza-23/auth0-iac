output "custom_domain_id" {
  value = auth0_custom_domain.this.id
}

output "verification_methods" {
  value       = auth0_custom_domain.this.verification[0].methods
  description = "DNS records to create so Auth0 can verify the domain"
}

output "status" {
  value = auth0_custom_domain.this.status
}
