provider "aws" {
  region     = "ap-south-1"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}
# Security Groups

resource "aws_security_group" "Docker" {
  name        = "Docker"
  description = "Allow inbound traffic"

  ingress {
    description      = "Custom TCP"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Banking-App-Sg"
  }
}

# Create Instance

resource "aws_instance" "Docker Server" {
  ami           = "ami-03cb1380eec7cc118"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Docker.id]
  key_name = "Staragile"

  tags = {
    Name = "Banking-App"
  }
  
}

