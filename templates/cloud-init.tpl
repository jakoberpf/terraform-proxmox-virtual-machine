#cloud-config

# users:
#   - name: kubespray
#     groups: sudo
#     shell: /bin/bash
#     sudo: ['ALL=(ALL) NOPASSWD:ALL']
#     ssh_authorized_keys:
#      - ${ssh_authorized_keys}
#   - name: maintenance
#     groups: [ sudo ]
#     shell: /bin/bash
#     lock_passwd: false
#     passwd: "$6$nqZiIASVBA.iF$9nubU0ImWVrv4XhtEq9XhSh9UYNFQ7yC9Lf7A.uheSlJ3cgI5d9ltkUwRq.X8lAwoQuLAMem6v.gJNGYwk5XA0"

packages:
  - qemu-guest-agent
  # - curl

runcmd:
  # Make sure the QEMU guest agent is running (should be already in the template)
  - systemctl start qemu-guest-agent
  # # Hosts
  # - echo "127.0.0.1  kube-node.internal" >> /etc/hosts
  # Expand root partition to maximum size
  - growpart /dev/vda 3
  - pvresize /dev/vda3
  - lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
  - resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
  # # Setup Zerotier
  # - curl -o zerotier-install.sh https://raw.githubusercontent.com/jakoberpf/zerotier-scripts/main/zerotier-installer.sh
  # - chmod +x zerotier-install.sh
  # - ./zerotier-install.sh
  # - curl -o zerotier-join.sh https://raw.githubusercontent.com/jakoberpf/zerotier-scripts/main/zerotier-join.sh
  # - chmod +x zerotier-join.sh
  # - ZTNETWORK=${zerotier_network_id} ./zerotier-join.sh && rm ./zerotier-join.sh

write_files:
  # # Zerotier
  # - path: /var/lib/zerotier-one/identity.public
  #   content: |
  #     ${zerotier_public_key}

  # - path: /var/lib/zerotier-one/identity.secret
  #   content: |
  #     ${zerotier_private_key}
