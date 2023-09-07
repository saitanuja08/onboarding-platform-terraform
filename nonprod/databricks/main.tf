module databricks {
  source = "../../modules/databricks"
  region = var.region
  team   = var.team
  policy_overrides = var.policy_overrides
  tags = var.tags
}
