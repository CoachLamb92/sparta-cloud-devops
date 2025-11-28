# Create 2 EC2 instances from AMIs, with assigned Security Groups,
# and a startup script where relevant

provider "aws" {
  region = "eu-west-1"
}

# APP INSTANCE
resource "aws_instance" "app_instance" {

  ami = var.app_ami_id

  instance_type = var.instance_type

  associate_public_ip_address = true

  tags = {
    Name = "${var.naming_prefix}app-tf-ec2"
  }

  vpc_security_group_ids = [var.app_security_group]

  key_name = var.instance_key_pair

  user_data = <<-EOF
    #!/bin/bash
    sleep 15
    cd /home/ubuntu
    cd sparta-app-code
    export DB_HOST=mongodb://${aws_instance.db_instance.public_ip}:27017/posts
    sudo npm install
    node seeds/seed.js
    pm2 start app.js
    EOF

}

# DB INSTANCE
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
