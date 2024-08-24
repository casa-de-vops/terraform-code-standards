
output "validation" {
  value = {
    config_variable      = var.config_variable
    pipeline_variable    = var.pipeline_variable
    environment_variable = var.environment_variable

    module_versions = {
      keeper_old = local.keeper_old
      keeper_new = local.keeper_new
    }
  }
}

output "this" {
  value = module.this
}
