data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "this" {
  name_prefix   = "autoscaling-template-"
  image_id      = data.aws_ami.latest.id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo yum install -y stress httpd
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "Hello from Terraform Auto-Scaling!" > /var/www/html/index.html
EOF
  )

  network_interfaces {
    associate_public_ip_address = true
  }
}

resource "aws_autoscaling_group" "this" {
  name                = "autoscaling-group"
  max_size            = 5
  min_size            = 2
  desired_capacity    = 2
  vpc_zone_identifier = var.public_subnets
  target_group_arns   = [var.aws_lb_target_group_arn]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "autoscaling-instance"
    propagate_at_launch = true
  }
}
