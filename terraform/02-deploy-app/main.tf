# Create an EC2 instance from an AMI with a start-up script in User Data
# and assigned Security Groups

provider "aws" {
  region = "eu-west-1"
}

# Making an instance from the AMI, given by the AMI ID
resource "aws_instance" "basic_instance" {

  ami = var.app_ami_id

  instance_type = var.instance_type

  associate_public_ip_address = true

  tags = {
    Name = "${var.naming_prefix}app-tf-ec2"
  }

  # Add security group ids
  vpc_security_group_ids = [var.app_security_group]

  key_name = var.instance_key_pair

  # Add user_data as a .sh file
  user_data = file("scripts/user-data-solo-ec2.sh")

}


