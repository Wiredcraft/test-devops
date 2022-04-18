#========================== VPC =============================

# Declare the data source
data "aws_availability_zones" "available" {}


# Define a vpc
resource "aws_vpc" "test_vpc" {
  cidr_block = var.test_network_cidr
  tags = {
    Name = "${var.test_vpc}"
  }
}

# Internet gateway for the public subnet
resource "aws_internet_gateway" "test_ig" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "test_ig"
  }
}

# Public subnet 1
resource "aws_subnet" "test_public_sn_01" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = var.test_public_01_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "test_public_sn_01"
  }
}

# Routing table for public subnet 1
resource "aws_route_table" "test_public_sn_rt_01" {
  vpc_id = aws_vpc.test_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_ig.id
  }

  tags = {
    Name = "test_public_sn_rt_01"
  }
}

# Associate the routing table to public subnet 1
resource "aws_route_table_association" "test_public_sn_rt_01_assn" {
  subnet_id      = aws_subnet.test_public_sn_01.id
  route_table_id = aws_route_table.test_public_sn_rt_01.id
}

# ECS Instance Security group
resource "aws_security_group" "test_public_sg" {
  name        = "test_public_sg"
  description = "Test public access security group"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }

  egress {
    # allow all traffic to private SN
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  tags = {
    Name = "test_public_sg"
  }
}
