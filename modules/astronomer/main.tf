resource "null_resource" "run_shell_script" {
  provisioner "local-exec" {
    command = "bash create-astronomer-resources.sh"
  }
}
