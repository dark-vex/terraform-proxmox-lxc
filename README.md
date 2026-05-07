# terraform-proxmox-lxc

Terraform module for Proxmox LXC containers using the [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox) provider.

## Usage

```hcl
module "container" {
  source = "github.com/dark-vex/terraform-proxmox-lxc?ref=v1.0.0"

  hostname         = "my-container"
  vmid             = 200
  node_name        = "pve"
  template_file_id = "local:vztmpl/debian-12-standard_12.0-1_amd64.tar.zst"

  cpu_cores = 2
  memory    = 1024

  ip_config = {
    ipv4_address = "192.168.1.100/24"
    ipv4_gateway = "192.168.1.1"
  }
}
```

See [`examples/basic/`](examples/basic/) for a full working example.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.83.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | >= 0.83.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [proxmox_virtual_environment_container.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_console"></a> [console](#input\_console) | Console configuration (set to enable console block) | <pre>object({<br/>    enabled   = optional(bool, true)<br/>    tty_count = optional(number, 2)<br/>    type      = optional(string, "tty")<br/>  })</pre> | `null` | no |
| <a name="input_cpu_architecture"></a> [cpu\_architecture](#input\_cpu\_architecture) | CPU architecture | `string` | `"amd64"` | no |
| <a name="input_cpu_cores"></a> [cpu\_cores](#input\_cpu\_cores) | Number of CPU cores | `number` | `1` | no |
| <a name="input_cpu_limit"></a> [cpu\_limit](#input\_cpu\_limit) | CPU limit | `number` | `0` | no |
| <a name="input_description"></a> [description](#input\_description) | Container description | `string` | `""` | no |
| <a name="input_disk_datastore"></a> [disk\_datastore](#input\_disk\_datastore) | Datastore for root disk | `string` | `"local-lvm"` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Root disk size in GB | `number` | `8` | no |
| <a name="input_features"></a> [features](#input\_features) | Container features | <pre>object({<br/>    nesting = optional(bool, false)<br/>    fuse    = optional(bool, false)<br/>    keyctl  = optional(bool, false)<br/>    mount   = optional(list(string), [])<br/>  })</pre> | `{}` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Container hostname | `string` | n/a | yes |
| <a name="input_ip_config"></a> [ip\_config](#input\_ip\_config) | IP configuration | <pre>object({<br/>    ipv4_address = optional(string, "dhcp")<br/>    ipv4_gateway = optional(string)<br/>    ipv6_address = optional(string)<br/>    ipv6_gateway = optional(string)<br/>  })</pre> | <pre>{<br/>  "ipv4_address": "dhcp"<br/>}</pre> | no |
| <a name="input_manage_user_account"></a> [manage\_user\_account](#input\_manage\_user\_account) | n/a | `bool` | `true` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory in MB | `number` | `512` | no |
| <a name="input_mount_points"></a> [mount\_points](#input\_mount\_points) | Additional mount points | <pre>list(object({<br/>    volume    = string<br/>    path      = string<br/>    size      = optional(string)<br/>    quota     = optional(bool, false)<br/>    replicate = optional(bool, false)<br/>    shared    = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_network_bridge"></a> [network\_bridge](#input\_network\_bridge) | Network bridge name | `string` | `"vmbr0"` | no |
| <a name="input_network_firewall"></a> [network\_firewall](#input\_network\_firewall) | Enable/Disable the Firewall | `bool` | `false` | no |
| <a name="input_network_interface_name"></a> [network\_interface\_name](#input\_network\_interface\_name) | Network interface name inside container | `string` | `"eth0"` | no |
| <a name="input_network_mac_address"></a> [network\_mac\_address](#input\_network\_mac\_address) | MAC address for network interface (optional) | `string` | `null` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Target Proxmox node name | `string` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | Operating system type (ubuntu, debian, centos, etc.) | `string` | `"ubuntu"` | no |
| <a name="input_password"></a> [password](#input\_password) | Root password | `string` | `null` | no |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | List of SSH public keys | `list(string)` | `[]` | no |
| <a name="input_start_on_boot"></a> [start\_on\_boot](#input\_start\_on\_boot) | Whether container should start on host boot | `bool` | `true` | no |
| <a name="input_started"></a> [started](#input\_started) | Whether container should be started after creation | `bool` | `true` | no |
| <a name="input_startup_down_delay"></a> [startup\_down\_delay](#input\_startup\_down\_delay) | Shutdown delay in seconds | `number` | `60` | no |
| <a name="input_startup_order"></a> [startup\_order](#input\_startup\_order) | Startup order (lower = earlier) | `number` | `10` | no |
| <a name="input_startup_up_delay"></a> [startup\_up\_delay](#input\_startup\_up\_delay) | Startup delay in seconds | `number` | `60` | no |
| <a name="input_swap"></a> [swap](#input\_swap) | Swap in MB | `number` | `0` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `list(string)` | <pre>[<br/>  "automation",<br/>  "lxc"<br/>]</pre> | no |
| <a name="input_template_file_id"></a> [template\_file\_id](#input\_template\_file\_id) | LXC template file ID | `string` | n/a | yes |
| <a name="input_unprivileged"></a> [unprivileged](#input\_unprivileged) | Run as unprivileged container | `bool` | `true` | no |
| <a name="input_vmid"></a> [vmid](#input\_vmid) | Container ID | `number` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_hostname"></a> [hostname](#output\_hostname) | Container hostname |
| <a name="output_id"></a> [id](#output\_id) | Container ID |
| <a name="output_ipv4_addresses"></a> [ipv4\_addresses](#output\_ipv4\_addresses) | IPv4 addresses assigned to the container |
| <a name="output_ipv6_addresses"></a> [ipv6\_addresses](#output\_ipv6\_addresses) | IPv6 addresses assigned to the container |
| <a name="output_vmid"></a> [vmid](#output\_vmid) | Container numeric ID |
<!-- END_TF_DOCS -->

## License

[MIT](LICENSE)
