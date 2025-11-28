resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr_block

  instance_tenancy = "default"

  tags = {
    Name = "${var.naming_prefix}tf-vpc"
  }

}

resource "aws_subnet" "app_subnet" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.app_subnet_cidr_block

  tags = {
    Name = "${var.naming_prefix}tf-public-sn"
  }

}

resource "aws_subnet" "db_subnet" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.db_subnet_cidr_block

  tags = {
    Name = "${var.naming_prefix}tf-private-sn"
  }

}

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.naming_prefix}tf-igw"
  }
}

resource "aws_route_table" "rt" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.naming_prefix}tf-public-rt"
  }
}

resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.rt.id
}
