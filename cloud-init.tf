data "template_file" "cloud_init" {
  template = file("${path.module}/templates/cloud-init.tpl")

  vars = {
    users    = var.cloud_init_users,
    commands = var.cloud_init_commands,
    files    = var.cloud_init_files
  }
}

# Transfer the file to the Proxmox Host
resource "remote_file" "this" {
  path        = format("%s/%s%s-%s.%s", var.cloud_init_file_path, var.cloud_init_file_prefix, var.id, local.name, var.cloud_init_file_type)
  content     = data.template_file.cloud_init.rendered
  permissions = var.cloud_init_permissions
}
