# Changelog

## v1.0.0 — 2026-05-07

### Added

- Initial release extracted from [dark-vex/infra-cd](https://github.com/dark-vex/infra-cd)
- `proxmox_virtual_environment_container` resource with `prevent_destroy` lifecycle guard
- Support for CPU, memory, disk, network, cloud-init, features, and mount points
- Outputs: `id`, `vmid`, `hostname`, `ipv4_addresses`, `ipv6_addresses`
