provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
} 

resource "aws_vpc" "prod-vpc" {
    cidr_block = “10.0.0.0/16”
    enable_dns_support = "true" 
    enable_dns_hostnames = "true" 
    enable_classiclink = "false"
    instance_tenancy = "default"    
    
    tags {
        Name = "prod-vpc"
    }
}

resource "aws_subnet" "prod-subnet-public-1" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "ap-northeast-1a"
    tags {
        Name = “prod-subnet-public-1”
    }
}

resource "aws_instance" "registry-server" {
  ami             = var.ami
  instance_type   = var.registry_instance_type
  key_name        = var.ami_key_pair_name
  subnet_id       = aws_subnet.prod-subnet-public-1.id
  security_groups = [aws_security_group.registry-server.id]
  tags = {
    Name = var.registry_instance_name
  }
}

output "registry-server-id" {
  value = aws_instance.registry-server.id
}

resource "aws_security_group" "registry-server" {
  name   = var.registry_instance_sg_name
  vpc_id = aws_vpc.prod-vpc.id
  ingress {
      cidr_blocks = [
        "0.0.0.0/0"
      ]
      from_port = 5000
      to_port   = 5000
      protocol  = "tcp"
    }
  egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_eip" "registry-server" {
  instance = aws_instance.registry-server.id
  vpc      = true
}

resource "aws_ebs_volume" "data-vol" {
 availability_zone = "ap-northeast-1d"
 size              = 100
 tags              = {
              Name = "data-volume"
 }
}

resource "aws_volume_attachment" "registry-server-vol" {
 device_name = "/dev/sdc"
 volume_id   = aws_ebs_volume.data-vol.id
 instance_id = aws_instance.registry-server.id
}
