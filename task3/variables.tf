variable "aws_access_key" {
default = "xxxxxxx"
}

variable "aws_secret_key" {
default = "yyyyyyy/"
}

variable "aws_region" {
default = "ap-northeast-1"
}

variable "ami" {
    default = "ami-yyyyyyyyyyyyyyyyy"
}

variable "registry_instance_type" {
  default = "t3.micro"
}

variable "registry_instance_name" {
  default = "Docker-Registry"
}

variable "registry_instance_sg_name" {
  default = "registry-server"
}

variable "ami_key_pair_name" { 
  default = "docker-registry-server"
}