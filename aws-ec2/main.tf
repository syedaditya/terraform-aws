terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.19.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}
resource "aws_instance" "myserver" {
  ami = "ami-0b8d527345fdace59"
  instance_type = "t3.micro"

  tags = {
    Name = "SampleServer"
  }
}