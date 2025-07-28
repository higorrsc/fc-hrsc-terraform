resource "aws_vpc" "fc-hrsc-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.prefix}-vpc"
  }
}

data "aws_availability_zones" "available" {}
# output "az" {
#   value = data.aws_availability_zones.available.names
# }

resource "aws_subnet" "subnets" {
  count                   = 2
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.fc-hrsc-vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true # Optional, if you want public subnets
  tags = {
    Name = "${var.prefix}-subnet-${count.index}"
  }
}

# resource "aws_subnet" "fc-hrsc-subnet-1" {
#   availability_zone = "us-east-1a"
#   vpc_id            = aws_vpc.fc-hrsc-vpc.id
#   cidr_block        = "10.0.0.0/24"
#   tags = {
#     Name = "${var.prefix}-subnet-1"
#   }
# }

# resource "aws_subnet" "fc-hrsc-subnet-2" {
#   availability_zone = "us-east-1b"
#   vpc_id            = aws_vpc.fc-hrsc-vpc.id
#   cidr_block        = "10.0.1.0/24"
#   tags = {
#     Name = "${var.prefix}-subnet-2"
#   }
# }

resource "aws_internet_gateway" "fc-hrsc-igw" {
  vpc_id = aws_vpc.fc-hrsc-vpc.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "fc-hrsc-rtb" {
  vpc_id = aws_vpc.fc-hrsc-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fc-hrsc-igw.id
  }
  tags = {
    Name = "${var.prefix}-rtb"
  }
}

resource "aws_route_table_association" "fc-hrsc-rta" {
  count          = 2
  subnet_id      = aws_subnet.subnets.*.id[count.index]
  route_table_id = aws_route_table.fc-hrsc-rtb.id
}
