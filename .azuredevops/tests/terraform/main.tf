

module "null" {
  source   = "../modules/null"
  for_each = local.null_modules
  trigger  = each.value
}