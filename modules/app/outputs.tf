output "client_id" {
  value = auth0_client.this.client_id
}

output "client_secret" {
  value     = auth0_client_credentials.this.client_secret
  sensitive = true
}
