resource "azuread_group" "example" {
  display_name     = "my_group"
  security_enabled = true
}

resource "azuread_user" "example_users" {
  for_each = toset(var.user_names)

  user_principal_name = "${each.value}@saitanuja0803gmail.onmicrosoft.com"
  display_name        = "${each.value} User"
  password            = "TempPassword123!"
  force_password_change = true

  depends_on = [ azuread_group.example ]
}

resource "azuread_group_member" "example" {
  for_each = azuread_user.example_users

  group_object_id  = azuread_group.example.id
  member_object_id = each.value.id
}