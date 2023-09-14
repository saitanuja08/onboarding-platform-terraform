provider "http" {
  alias = "collibra"
}

variable "collibra_base_url" {
  description = "Collibra base URL"
  type        = string
  default     = "https://your-collibra-instance.com"
}

variable "collibra_token" {
  description = "Collibra API token"
  type        = string
}

resource "http_request" "create_collibra_user" {
  provider = http.collibra
  method   = "POST"
  url      = "${var.collibra_base_url}/api/rest/2.0/users"

  headers = {
    "Content-Type" = "application/json"
    "Authorization" = "Bearer ${var.collibra_token}"
  }

  body = jsonencode({
    "name"     = "John Doe"
    "username" = "johndoe"
    "email"    = "johndoe@example.com"
    "role"     = "USER"
  })
}

output "user_creation_response" {
  value = http_request.create_collibra_user.body
}
:wq!
