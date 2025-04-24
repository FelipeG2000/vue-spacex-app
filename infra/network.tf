resource "aws_vpc" "frontend_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "frontend-vpc"
  }
}

resource "aws_subnet" "frontend_subnet" {
  vpc_id                  = aws_vpc.frontend_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "frontend-subnet"
  }
}

resource "aws_subnet" "frontend_subnet_b" {
  vpc_id                  = aws_vpc.frontend_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "frontend-subnet-b"
  }
}

resource "aws_route_table_association" "frontend_route_assoc_b" {
  subnet_id      = aws_subnet.frontend_subnet_b.id
  route_table_id = aws_route_table.frontend_route_table.id
}


resource "aws_internet_gateway" "frontend_igw" {
  vpc_id = aws_vpc.frontend_vpc.id

  tags = {
    Name = "frontend-igw"
  }
}

resource "aws_route_table" "frontend_route_table" {
  vpc_id = aws_vpc.frontend_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.frontend_igw.id
  }

  tags = {
    Name = "frontend-route-table"
  }
}

resource "aws_route_table_association" "frontend_route_assoc" {
  subnet_id      = aws_subnet.frontend_subnet.id
  route_table_id = aws_route_table.frontend_route_table.id
}
