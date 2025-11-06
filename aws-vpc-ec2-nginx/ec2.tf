resource "aws_instance" "nginxserver" {
  ami           = "ami-0b8d527345fdace59"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public-subnet.id
  
  user_data = <<-EOF
            #!/bin/bash
            sudo yum install nginx -y
            sudo systemctl start nginx 
            EOF
  tags = {
    Name = "nginxserver"
  }
}
