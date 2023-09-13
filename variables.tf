variable "id" {
  type = number
}

variable "name" {
  type = string
}

variable "target_node" {
  type = string
}

variable "instance_template" {
  type = string
}

variable "instance_os_type" {
  type = string
}

variable "instance_memory" {
  type    = number
  default = 4096
}

variable "instance_cpus" {
  type    = string
  default = 2
}

variable "instance_disk" {
  type    = string
  default = "8192M"
}

variable "network_address" {
  type    = string
  default = null
}

variable "network_gateway" {
  type    = string
  default = null
}

variable "ssh_authorized_keys" {
  type = string
}

variable "ssh_secret_key" {
  type = string
}

variable "cloud_init_file_path" {
  type    = string
  default = "/var/lib/vz/snippets"
}

variable "cloud_init_file_prefix" {
  type    = string
  default = "cloud_init_"
}

variable "cloud_init_file_type" {
  type    = string
  default = "yaml"
}

variable "cloud_init_permissions" {
  type    = string
  default = "0644"
}

variable "cloud_init_users" {
  type = list(object({
    username = string,
    password = string
  }))
  default = []
}

variable "cloud_init_commands" {
  type    = list(string)
  default = []
}

variable "cloud_init_files" {
  type = list(object({
    path    = string
    content = string
  }))
  default = []
}
