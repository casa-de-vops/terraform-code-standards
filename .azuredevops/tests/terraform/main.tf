locals {
  these = [
    "Hello, World!",
    "Goodbye, World!"
  ]
}
module "this" {
  source   = "../modules/this"
  for_each = { for k, v in local.these : k => v }
  this  = each.value
}
