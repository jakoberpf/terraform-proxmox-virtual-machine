locals {
  name = format("%s-%s", var.name, random_string.deployment_id.result)
}

# Create virtual machine
# Example: https://github.com/Telmate/terraform-provider-proxmox/blob/master/proxmox/resource_vm_qemu.go
resource "proxmox_vm_qemu" "this" {
  ## Wait for the cloud-config file to exist
  depends_on = [
    remote_file.this
  ]

  name        = local.name
  vmid        = var.id
  target_node = var.target_node

  # Clone from specififed template
  clone   = var.instance_template
  os_type = "cloud-init"

  # CloudInit - set network IP and gateway if specified, otherwise use dhcp
  ipconfig0 = var.network_address != null && var.network_gateway != null ? format("ip=%s,gateway=%s", var.network_address, var.network_gateway) : "ip=dhcp"
  cicustom  = format("%s/%s%s-%s.%s", "user=local:snippets", var.cloud_init_file_prefix, var.id, local.name, var.cloud_init_file_type)

  memory = var.instance_memory
  cores  = var.instance_cpus
  agent  = 1

  # Set the boot disk paramters
  bootdisk = "virtio0"
  scsihw   = "virtio-scsi-pci"

  disk {
    size    = var.instance_disk
    type    = "virtio"
    storage = "glacier_disks_v1"
  }

  # Set the network
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Serial interface of type socket is used by xterm.js
  # You will need to configure your guest system before being able to use it
  serial {
    id   = 0
    type = "socket"
  }

  # Ignore changes to the network
  ## MAC address is generated on every apply, causing
  ## TF to think this needs to be rebuilt on every apply
  lifecycle {
    ignore_changes = [
      network
    ]
    replace_triggered_by = [
      remote_file.this
    ]
  }
}
