module "null" {
  source   = "../modules/null"
  for_each = { for k, v in local.null_modules : k => v }
  trigger  = each.value
}