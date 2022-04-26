# main creds for AWS connection

variable "region" {
  description = "AWS region"
}

variable "availability_zone" {
  description = "availability zone used for the demo, based on region"
  default = {
    us-east-1 = "us-east-1"
  }
}

variable "ecs_key_pair_name" {
  description = "ECS key pair name"
}

########################### VPC Config ################################

variable "test_vpc" {
  description = "VPC for Test environment"
}

variable "test_network_cidr" {
  description = "IP addressing for Test Network"
}

variable "test_public_01_cidr" {
  description = "Public 0.0 CIDR for externally accessible subnet"
}

########################### ECS Config ################################

variable "test_ecs_name" {
  description = "ECS for Test environment"
}

variable "test_ami_id" {
  description = "ECS AMI for Test environment"
}
