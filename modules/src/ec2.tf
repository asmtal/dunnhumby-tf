resource "aws_key_pair" "key_connect" {
  key_name = "key_connect"
  public_key = ""//Pub key or aws secret manager to load the key here
}

resource "aws_launch_template" "dh_datapipeline" {
  name                   = "dh-datapipeline"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name               = aws_key_pair.key_connect.key_name
  iam_instance_profile {
    name = "dunnhumby_profile"
  }
  monitoring {
    enabled = true
  }
  tag_specifications {
    resource_type = "instance"
  }
  tags      = var.generic_tags
  user_data = filebase64("${path.module}/templates/docker.sh")
}

resource "aws_autoscaling_group" "dh_datapipeline-asg" {
  name                = "dh-datapipeline-asg"
  vpc_zone_identifier = [aws_subnet.dunnhumby_subnet.id]
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1

  launch_template {
    id      = aws_launch_template.dh_datapipeline.id
    version = "$Latest"
  }
  lifecycle {
    create_before_destroy = true
  }
}