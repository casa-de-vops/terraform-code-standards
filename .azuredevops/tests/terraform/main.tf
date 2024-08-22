variable "config_variable" {
  type    = string
  default = "config_value"
}

variable "command_option_args" {
  type    = string
  default = "default_value"
}

variable "input_environment_file" {
  type    = string
  default = "default_value"
}

locals {
  test_kv_version = "__kv_module_version__"
  test_eh_version = "__eh_module_version__"
}

output "output_variable" {
  value = {
    config      = var.config_variable
    cmd_options = var.command_option_args
    env_file    = var.input_environment_file
    kv_version  = local.test_kv_version
    eh_version  = local.test_eh_version
  }
}
