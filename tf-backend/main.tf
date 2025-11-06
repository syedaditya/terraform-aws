terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.19.0"
    }
  }
  backend "s3" {
    bucket = "demo-bucket-3f6f55a8815a5a52"
    key = "backend.tfstate"
    region = "ap-southeast-2"
  }
}



provider "aws" {
  # Configuration options
  region = "ap-southeast-2"
}
resource "aws_instance" "myserver" {
  ami = "ami-0b8d527345fdace59"
  instance_type = "t3.micro"

  tags = {
    Name = "SampleServer"
  }
}