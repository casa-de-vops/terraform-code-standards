

module "null" {
  source   = "../modules/null"
  for_each = tolist(local.null_modules)
  trigger  = each.value
}