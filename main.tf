resource "proxmox_virtual_environment_container" "this" {
  description = var.description

  node_name = var.node_name
  vm_id     = var.vmid

  unprivileged = var.unprivileged

  dynamic "console" {
    for_each = var.console != null ? [var.console] : []
    content {
      enabled   = console.value.enabled
      tty_count = console.value.tty_count
      type      = console.value.type
    }
  }

  initialization {
    hostname = var.hostname

    dynamic "ip_config" {
      for_each = var.network_interfaces
      content {
        ipv4 {
          address = ip_config.value.ipv4_address
          gateway = ip_config.value.ipv4_gateway
        }
        dynamic "ipv6" {
          for_each = ip_config.value.ipv6_address != null ? [1] : []
          content {
            address = ip_config.value.ipv6_address
            gateway = ip_config.value.ipv6_gateway
          }
        }
      }
    }

    dynamic "user_account" {
      for_each = var.manage_user_account ? [1] : []
      content {
        keys     = var.ssh_keys
        password = var.password
      }
    }
  }

  dynamic "network_interface" {
    for_each = var.network_interfaces
    content {
      name        = coalesce(network_interface.value.name, network_interface.key)
      bridge      = network_interface.value.bridge
      mac_address = network_interface.value.mac_address
      firewall    = network_interface.value.firewall
      enabled     = network_interface.value.enabled
      mtu         = network_interface.value.mtu
      vlan_id     = network_interface.value.vlan_id
      rate_limit  = network_interface.value.rate_limit
    }
  }

  disk {
    datastore_id = var.disk_datastore
    size         = var.disk_size
  }

  operating_system {
    template_file_id = var.template_file_id
    type             = var.os_type
  }

  cpu {
    cores        = var.cpu_cores
    limit        = var.cpu_limit
    architecture = var.cpu_architecture
  }

  memory {
    dedicated = var.memory
    swap      = var.swap
  }

  startup {
    order      = tostring(var.startup_order)
    up_delay   = tostring(var.startup_up_delay)
    down_delay = tostring(var.startup_down_delay)
  }

  start_on_boot = var.start_on_boot
  started       = var.started

  tags = var.tags

  dynamic "features" {
    for_each = var.features.nesting || var.features.fuse || var.features.keyctl || length(var.features.mount) > 0 ? [1] : []
    content {
      nesting = var.features.nesting
      fuse    = var.features.fuse
      keyctl  = var.features.keyctl
      mount   = var.features.mount
    }
  }

  dynamic "mount_point" {
    for_each = var.mount_points
    content {
      volume    = mount_point.value.volume
      path      = mount_point.value.path
      size      = mount_point.value.size
      quota     = mount_point.value.quota
      replicate = mount_point.value.replicate
      shared    = mount_point.value.shared
    }
  }

  lifecycle {
    ignore_changes = [
      # Ignore template changes after creation
      operating_system[0].template_file_id,
      # initialization.user_account (keys/password) is ForceNew in the
      # bpg/proxmox provider schema. Do NOT remove this — with
      # prevent_destroy = true below, any real diff here would make
      # Terraform try to replace the container and fail the apply.
      # Credential changes must go through an out-of-band `pct set`
      # (safe: this attribute is permanently ignored, so Terraform won't
      # revert it) or a deliberate destroy+recreate.
      initialization[0].user_account,
    ]
    prevent_destroy = true
  }
}
