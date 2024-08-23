resource "null_resource" "this" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    test_kv_version = local.test_kv_version
    test_eh_version = local.test_eh_version
  }

  provisioner "remote-exec" {
    # Bootstrap script 
    inline = [
      "echo 'Hello, World!'",
    ]
  }
}