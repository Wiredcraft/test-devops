resource "aws_subnet" "mysubnt-b1" {
    vpc_id                  = "vpc-054a32cba12d43efe"
    cidr_block              = "172.17.1.0/24"
    availability_zone       = "cn-northwest-1b"
    map_public_ip_on_launch = false
 
    tags {
        Name = "mysubnt-b1"
    }
}





