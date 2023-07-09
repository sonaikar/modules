variable "vm-count" {}
variable "create_vpc" {}
variable "cidr" {}
variable "region" {}
variable "availability_zone" {}

variable "enable_dns_hostnames" {
  type = bool
  default = true
}

variable "enable_dns_support" {
  type = bool
  default = true
}

variable "public_subnets" {}

variable "ssh-location" {
  default = "0.0.0.0/0"
  description = "SSH variable for bastion host"
  type = string
}
