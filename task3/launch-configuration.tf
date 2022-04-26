resource "aws_launch_configuration" "ecs-launch-configuration" {
  name                 = "${var.test_ecs_name}"
  image_id             = "${var.test_ami_id}"
  instance_type        = "t1.micro"
  iam_instance_profile = aws_iam_instance_profile.ecs-instance-profile.id

  root_block_device {
    volume_type           = "standard"
    volume_size           = 100
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  security_groups             = ["${aws_security_group.test_public_sg.id}"]
  associate_public_ip_address = "true"
  key_name                    = var.ecs_key_pair_name
}
