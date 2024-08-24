
output "output_validation" {
  value = {
    config      = var.config_variable
    cmd_options = var.command_option_args
    env_file    = var.input_environment_file
    kv_version  = local.kv_keeper
    eh_version  = local.eh_keeper
  }
}

output "this" {
  value = module.this
}