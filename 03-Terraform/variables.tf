# Variables for general information
######################################
 
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}
 
variable "owner" {
  description = "Configuration owner"
  type        = string
  default     = "Terraform"
}
 
variable "aws_region_az" {
  description = "AWS region availability zone"
  type        = string
  default     = "a"
}

variable "aws_sg" {
  description = "AWS Security Group"
  type        = string
  default     = "sg-03c1ae7048c7f501b"
}

variable "aws_subnet" {
  description = "AWS Subnet"
  type        = string
  default     = "subnet-b3b04af9"
}
 
variable "instance_ami" {
  description = "ID of the AMI used"
  type        = string
  default     = "ami-003ba08113592046f"
}
 
variable "instance_type" {
  description = "Type of the instance"
  type        = string
  default     = "t2.micro"
}
 
variable "key_pair" {
  description = "SSH Key pair used to connect"
  type        = string
  default     = "qq2aws2"
}
 
variable "root_device_type" {
  description = "Type of the root block device"
  type        = string
  default     = "gp2"
}
 
variable "root_device_size" {
  description = "Size of the root block device"
  type        = string
  default     = "50"
}
