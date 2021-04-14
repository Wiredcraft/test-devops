resource "aws_vpc" "myvpc" {
  cidr_block = "172.17.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
 
  tags = {
    Name = "myvpc"
  }
}




