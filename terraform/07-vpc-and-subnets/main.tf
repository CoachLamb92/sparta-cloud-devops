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
