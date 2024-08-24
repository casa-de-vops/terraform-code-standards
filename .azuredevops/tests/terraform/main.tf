

module "null" {
  source   = "../modules/null"
  for_each = tomap(local.null_modules)
  trigger  = each.value
}