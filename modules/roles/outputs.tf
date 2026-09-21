output "role_ids" {
  value       = { for name, role in auth0_role.this : name => role.id }
  description = "Role IDs keyed by role name"
}
