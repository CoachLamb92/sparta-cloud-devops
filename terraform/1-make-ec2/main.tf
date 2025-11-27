# Create an EC2 instance from an AMI

# Provider block - What providers do we need to interact with?

# We are using aws
provider "aws" {
  region = "eu-west-1"

  # Terraform will download all the required depenedcies/plugins when you run "terraform init"
}

# resource: keyword to denote a resource
# "aws_instance": the type of resource
# "basic_instance": a reference to this resource for use elsewhere in code
resource "aws_instance" "basic_instance" {
  # AMI ID
  ami = var.app_ami_id

  # Instance type
  instance_type = var.instance_type

  # We want auto-assigned public IP
  associate_public_ip_address = true

  key_name = var.instance_key_pair

  # Name instance for AWS
  tags = {
    Name = "${var.naming_prefix}app-tf-ec2"
  }

}
