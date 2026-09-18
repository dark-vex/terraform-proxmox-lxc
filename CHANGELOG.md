# Changelog

## v2.0.0 — 2026-09-18

### Changed

- **BREAKING:** Removed `network_bridge`, `network_interface_name`, `network_mac_address`, `network_firewall`, and `ip_config` variables. Replaced with a single `network_interfaces` map variable, keyed by container-side interface name, supporting multiple NICs (fixes #2).

  Migration:
  ```hcl
  # Before
  network_bridge      = "vmbr0"
  network_mac_address = "aa:bb:cc:dd:ee:ff"
  ip_config = {
    ipv4_address = "192.168.1.100/24"
    ipv4_gateway = "192.168.1.1"
  }

  # After
  network_interfaces = {
    eth0 = {
      bridge       = "vmbr0"
      mac_address  = "aa:bb:cc:dd:ee:ff"
      ipv4_address = "192.168.1.100/24"
      ipv4_gateway = "192.168.1.1"
    }
    eth1 = {
      bridge       = "vmbr1"
      ipv4_address = "10.0.5.20/24"
      ipv4_gateway = "10.0.5.1"
    }
  }
  ```
  Callers using only defaults (no explicit values for the removed variables) see no plan diff on upgrade.

## v1.0.0 — 2026-05-07

### Added

- Initial release extracted from [dark-vex/infra-cd](https://github.com/dark-vex/infra-cd)
- `proxmox_virtual_environment_container` resource with `prevent_destroy` lifecycle guard
- Support for CPU, memory, disk, network, cloud-init, features, and mount points
- Outputs: `id`, `vmid`, `hostname`, `ipv4_addresses`, `ipv6_addresses`
