resource "aws_vpc" "dev_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.subnet1_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name_prefix}-public-subnet-1"
  }
}

resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}