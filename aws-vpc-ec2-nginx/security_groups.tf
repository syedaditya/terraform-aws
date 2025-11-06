resource "aws_security_group " "nginx-sg" {
  vpc_id = aws_vpc.my_vpc.id

  #   inbound rules for http
  ingress {
    from_port  = 80
    to_port    = 80
    protocol   = "tcp"
    cidr_block = ["0.0.0.0/0"]
  }

  #   outbound rules for https

  egress {
    from_port  = 0    //this means this is applicable for each and every port
    to_port    = 0    //this means this is applicable for each and every port
    protocol   = "-1" //-1 means this is applicable for every protocol
    cidr_block = ["0.0.0.0/0"]
  }
  tags = {
    name = "nginx-sg"
  }
}
