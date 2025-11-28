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

# APP INSTANCE
resource "aws_instance" "app_instance" {

  ami = var.app_ami_id

  subnet_id = aws_subnet.app_subnet.id

  instance_type = var.instance_type

  associate_public_ip_address = true

  tags = {
    Name = "${var.naming_prefix}app-tf-ec2"
  }

  vpc_security_group_ids = [aws_security_group.app_security_group.id]

  key_name = var.instance_key_pair

  user_data = <<-EOF
    #!/bin/bash
    sleep 15
    cd /home/ubuntu
    cd sparta-app-code
    export DB_HOST=mongodb://${aws_instance.db_instance.private_ip}:27017/posts
    sudo npm install
    node seeds/seed.js
    pm2 start app.js
    EOF

}

# DB INSTANCE
resource "aws_instance" "db_instance" {

  ami = var.db_ami_id

  subnet_id = aws_subnet.db_subnet.id

  instance_type = var.instance_type

  associate_public_ip_address = false

  tags = {
    Name = "${var.naming_prefix}db-tf-ec2"
  }

  vpc_security_group_ids = [aws_security_group.db_security_group.id]

  key_name = var.instance_key_pair
}

resource "aws_security_group" "app_security_group" {

  name        = "${var.naming_prefix}tf-public-sg"
  description = "${var.naming_prefix}tf-public-sg"

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.naming_prefix}tf-public-sg"
  }
}

resource "aws_security_group" "db_security_group" {

  name        = "${var.naming_prefix}tf-private-sg"
  description = "${var.naming_prefix}tf-private-sg"

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.naming_prefix}tf-private-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_access" {
  security_group_id = aws_security_group.app_security_group.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_mongodb_access" {
  security_group_id = aws_security_group.db_security_group.id
  from_port         = 27017
  cidr_ipv4         = var.app_subnet_cidr_block
  ip_protocol       = "tcp"
  to_port           = 27017
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_access_public" {
  security_group_id = aws_security_group.app_security_group.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_access_private" {
  security_group_id = aws_security_group.db_security_group.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_public" {
  security_group_id = aws_security_group.app_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_private" {
  security_group_id = aws_security_group.db_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
