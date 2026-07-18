resource "auth0_connection_client" "this" {
  connection_id = var.connection_id
  client_id     = var.client_id
}
