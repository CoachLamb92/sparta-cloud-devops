# Create an EC2 instance

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
  ami = "ami-09c949f954724690f"

  # Instance type
  instance_type = "t3.micro"

  # We want auto-assigned public IP
  associate_public_ip_address = true

  # Name instance for AWS
  tags = {
    Name = "se-morgan-test-tf-ec2"
  }

}
