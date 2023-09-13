# Proxmox VM for samba

This module provisions a Proxmox VM, configured as samba server.

## Ressources:

- [telemate - clout_init](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/guides/cloud_init)
- [telemate - vm_qemu](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu)

https://www.splunk.com/en_us/blog/devops/writing-ansible-playbooks-for-new-terraform-servers.html
https://www.cprime.com/resources/blog/terraform-and-ansible-tutorial-integrating-terraform-managed-instances-with-ansible-control-nodes/
https://www.digitalocean.com/community/tutorials/how-to-use-ansible-with-terraform-for-configuration-management
https://thesmarthomejourney.com/2021/09/26/home-server-users-samba-shares/

## Expand LVM Volume

```bash
growpart /dev/vda 3
pvresize /dev/vda3
lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
```

## Add local user bin to PATH

```bash
export PATH="$HOME/.local/bin:$PATH"
```
