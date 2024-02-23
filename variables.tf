variable "enabled" {
  type    = bool
  default = true
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "vpc_name" {
  description = "The vpc name."
  default     = "tf-modules-vpc"
}

variable "vpc_cidr" {
  description = "The cidr block."
  default     = "172.16.0.0/16"
}

variable "vpc_is_multicast" {
  description = "Specify the vpc is multicast."
  default     = true
}

variable "vpc_dns_servers" {
  description = "Specify the vpc dns servers."
  type        = list(string)
  default     = []
}

variable "subnet_cidrs" {
  description = "Specify the subnet cidr blocks."
  type        = list(string)
  default     = []
}

variable "eni_subnet_cidrs" {
  description = "Specify the Pod subnet cidr blocks."
  type        = list(string)
  default     = []
}

variable "subnet_is_multicast" {
  description = "Specify the subnet is multicast."
  default     = true
}

variable "availability_zones" {
  description = "List of available zones to launch resources."
  type        = list(string)
  default     = []
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways."
  type        = bool
  default     = true
}

variable "nat_eip_max_bandwidth" {
  description = "Set the maximum bandwidth of the EIP associated with the NAT gateway."
  type        = number
  default     = 100

}
