resource "aws_instance" "myinstance" {
  ami           = "ami-0135cb179d33fbe3e"
  instance_type = "t2.medium"
 
  key_name = "dev"
  subnet_id = "subnet-0b3cebdaada76cfac"
  private_ip = "172.17.1.101"
 
  tags = {
        Name = "myinstance"
  }
}




