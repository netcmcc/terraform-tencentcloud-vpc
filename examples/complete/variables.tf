variable "region" {
  description = "The application's account region"
  type        = string
}

variable "vpc_name" {
  description = "The vpc name."
  default     = "tf-modules-vpc"
}

variable "vpc_cidr" {
  description = "The cidr block."
  default     = "172.16.0.0/16"
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
