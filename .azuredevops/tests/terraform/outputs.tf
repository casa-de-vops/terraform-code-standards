
output "output_variable" {
  value = {
    config      = var.config_variable
    cmd_options = var.command_option_args
    env_file    = var.input_environment_file
    kv_version  = local.test_kv_version
    eh_version  = local.test_eh_version
  }
}
