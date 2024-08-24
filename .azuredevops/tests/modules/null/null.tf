resource "null_resource" "this" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    keeper_key = var.trigger
  }

  provisioner "remote-exec" {
    # Bootstrap script 
    inline = [
      "echo '${var.trigger}!'",
    ]
  }
}