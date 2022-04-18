output "region" {
  value = var.region
}

output "test_vpc_id" {
  value = aws_vpc.test_vpc.id
}

output "test_public_sn_01_id" {
  value = aws_subnet.test_public_sn_01.id
}

output "test_public_sg_id" {
  value = aws_security_group.test_public_sg.id
}

output "test_ecs_name" {
  value = var.test_ecs_name
}

output "test_ami_id" {
  value = var.test_ami_id
}