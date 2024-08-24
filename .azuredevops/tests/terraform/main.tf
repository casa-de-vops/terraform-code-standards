

module "null" {
  source   = "../modules/null"
  for_each = { for k, v in local.local.null_modules : k => k }
  trigger  = each.value
}