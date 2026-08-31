variable "logo_url" {
  type        = string
  default     = null
  description = "URL of the logo shown on login pages"
}

variable "favicon_url" {
  type        = string
  default     = null
  description = "URL of the favicon"
}

variable "primary_color" {
  type        = string
  default     = "#0059d6"
  description = "Primary button background color, hexadecimal"
}

variable "page_background_color" {
  type        = string
  default     = "#000000"
  description = "Login page background color, hexadecimal"
}

variable "font_url" {
  type        = string
  default     = null
  description = "URL of a custom font for login pages"
}

variable "login_page_html" {
  type        = string
  default     = null
  description = "Custom HTML for the classic login page, typically file(\"login.html\"). Leave null to keep Auth0's default page"
}
