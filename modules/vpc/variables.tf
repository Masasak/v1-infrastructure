variable "name_prefix" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_ipv6_cidr" {
  type = string
}

variable "azs" {
  type    = list(string)
}

variable "public_subnets" {
  type    = list(string)
}

variable "private_subnets" {
  type    = list(string)
}

variable "private_subnet_tags" {
  type = map(string)
}

variable "public_subnet_tags" {
  type = map(string)
}