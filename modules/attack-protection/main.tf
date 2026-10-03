# Singleton - one per tenant.
resource "auth0_attack_protection" "this" {
  brute_force_protection {
    enabled      = var.brute_force_protection.enabled
    max_attempts = var.brute_force_protection.max_attempts
    mode         = var.brute_force_protection.mode
    shields      = var.brute_force_protection.shields
    allowlist    = var.brute_force_protection.allowlist
  }

  suspicious_ip_throttling {
    enabled   = var.suspicious_ip_throttling.enabled
    shields   = var.suspicious_ip_throttling.shields
    allowlist = var.suspicious_ip_throttling.allowlist
  }

  breached_password_detection {
    enabled = var.breached_password_detection.enabled
    method  = var.breached_password_detection.method
    shields = var.breached_password_detection.shields
  }
}
