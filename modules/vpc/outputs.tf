output "aws_vpc_id" {
  value = aws_vpc.fc-hrsc-vpc.id
}

output "aws_subnet_ids" {
  value = aws_subnet.subnets[*].id
}
