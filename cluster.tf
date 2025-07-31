resource "aws_security_group" "fc-hrsc-sg" {
  vpc_id = aws_vpc.fc-hrsc-vpc.id
  egress = [{
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    prefix_list_ids  = []
    ipv6_cidr_blocks = []
    security_groups  = []
    self             = false
    description      = "Allow all outbound traffic"
  }]
  tags = {
    Name = "${var.prefix}-sg"
  }
}
