variable "vpc_cidr" {
  type    = string
  default = "10.123.0.0/16"
}

variable "name_prefix" {
  type    = string
  default = "dev_station"
}

variable "subnet1_cidr" {
  type    = string
  default = "10.123.1.0/24"
}