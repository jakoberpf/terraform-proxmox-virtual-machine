data "template_file" "cloud_init" {
  template = file("${path.module}/templates/cloud-init.tpl")

  vars = {
    users                = local.cloud_init_users,
    commands             = local.cloud_init_commands,
    files                = local.cloud_init_files,
    zerotier_network_id  = var.zerotier_network_id
    zerotier_public_key  = zerotier_identity.this.public_key
    zerotier_private_key = zerotier_identity.this.private_key
  }
}

# Transfer the file to the Proxmox Host
resource "remote_file" "this" {
  path        = format("%s/%s%s-%s.%s", var.cloud_init_file_path, var.cloud_init_file_prefix, var.id, local.name, var.cloud_init_file_type)
  content     = data.template_file.cloud_init.rendered
  permissions = var.cloud_init_permissions
}
