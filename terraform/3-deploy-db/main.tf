# Create a DB EC2 instance from an AMI, with assigned Security Groups

provider "aws" {
  region = "eu-west-1"
}

# Making an instance from the AMI, given by the AMI ID
resource "aws_instance" "db_instance" {

  ami = var.db_ami_id

  instance_type = var.instance_type

  associate_public_ip_address = true

  tags = {
    Name = "${var.naming_prefix}db-tf-ec2"
  }

  vpc_security_group_ids = [var.db_security_group]

  key_name = var.instance_key_pair

}

