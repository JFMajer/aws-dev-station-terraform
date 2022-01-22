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

variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "root_volume_size" {
  type    = string
  default = "10"
}

variable "host_os" {
  type    = string
  default = "linux"
}


variable "home_ip" {}
variable "station_public_key_path" {}
variable "station_private_key_path" {}