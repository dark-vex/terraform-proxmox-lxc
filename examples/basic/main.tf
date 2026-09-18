terraform {
  required_version = ">= 1.5.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.83.0"
    }
  }
}

variable "proxmox_endpoint" {
  description = "Proxmox API endpoint URL"
  type        = string
}

variable "proxmox_username" {
  description = "Proxmox API username (e.g. root@pam)"
  type        = string
}

variable "proxmox_password" {
  description = "Proxmox API password"
  type        = string
  sensitive   = true
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  username = var.proxmox_username
  password = var.proxmox_password
  insecure = true
}

module "container" {
  source = "../.."

  hostname         = "example-lxc"
  vmid             = 200
  node_name        = "pve"
  template_file_id = "local:vztmpl/debian-12-standard_12.0-1_amd64.tar.zst"

  cpu_cores = 2
  memory    = 1024

  network_interfaces = {
    eth0 = {
      ipv4_address = "192.168.1.100/24"
      ipv4_gateway = "192.168.1.1"
    }
  }
}
