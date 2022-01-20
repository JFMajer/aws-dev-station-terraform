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

resource "aws_route_table" "dev_public_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "${var.name_prefix}-public-route-table"
  }
}

resource "aws_route" "dev_public_route" {
  route_table_id         = aws_route_table.dev_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev_igw.id
}

resource "aws_route_table_association" "dev_public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.dev_public_route_table.id
}

resource "aws_security_group" "dev_public_security_group" {
  vpc_id      = aws_vpc.dev_vpc.id
  name        = "${var.name_prefix}-public-security-group"
  description = "Security group for the public subnet"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.home_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-public-security-group"
  }
}

resource "aws_key_pair" "dev_station_key_pair" {
  key_name   = "${var.name_prefix}-key-pair"
  public_key = file("${var.station_public_key_path}")
}

resource "aws_instance" "dev_station" {
  ami                    = data.aws_ami.ubuntu_image.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.dev_station_key_pair.id
  vpc_security_group_ids = [aws_security_group.dev_public_security_group.id]
  subnet_id              = aws_subnet.public_subnet_1.id
  user_data              = file("userdata.tpl")

  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = {
    Name = "${var.name_prefix}-ec2"
  }
}
