
output "validation" {
  value = {
    config_variable      = var.config_variable
    pipeline_variable    = var.pipeline_variable
    environment_variable = var.environment_variable

    module_versions = {
      kv_keeper = local.kv_keeper
      eh_keeper = local.eh_keeper
    }
  }
}

output "this" {
  value = module.this
}
