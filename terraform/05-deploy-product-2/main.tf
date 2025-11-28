# Create 2 EC2 instances from AMIs, with assigned Security Groups,
# and a startup script where relevant

provider "aws" {
  region = "eu-west-1"
}

# APP INSTANCE
resource "aws_instance" "app_instance" {

  ami = var.ami_id

  instance_type = var.instance_type

  associate_public_ip_address = true

  tags = {
    Name = "${var.naming_prefix}${var.naming_suffix}"
  }

  vpc_security_group_ids = [var.security_group]

  key_name = var.instance_key_pair

  user_data = var.user_data

}
