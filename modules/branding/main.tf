resource "auth0_branding" "this" {
  logo_url    = var.logo_url
  favicon_url = var.favicon_url

  colors {
    primary         = var.primary_color
    page_background = var.page_background_color
  }

  dynamic "font" {
    for_each = var.font_url != null ? [var.font_url] : []
    content {
      url = font.value
    }
  }
}

# Custom login page HTML (classic Universal Login only). Skipped unless login_page_html is set; the
# New Universal Login is themed through auth0_branding above instead.
resource "auth0_pages" "this" {
  count = var.login_page_html != null ? 1 : 0

  login {
    enabled = true
    html    = var.login_page_html
  }
}
