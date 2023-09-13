data "template_file" "cloud_init" {
  template = file("${path.module}/templates/cloud-init.tpl")

  vars = {
    ssh_authorized_keys = var.ssh_authorized_keys,
    /* users    = var.cloud_init_users,
    commands = var.cloud_init_commands,
    files    = var.cloud_init_files */
    zerotier_network_id  = "",
    zerotier_public_key  = "",
    zerotier_private_key = ""
  }
}

# Transfer the file to the Proxmox Host
resource "remote_file" "this" {
  path        = format("%s/%s%s-%s.%s", var.cloud_init_file_path, var.cloud_init_file_prefix, var.id, local.name, var.cloud_init_file_type)
  content     = data.template_file.cloud_init.rendered # TODO add cloud_init override
  permissions = var.cloud_init_permissions
}
