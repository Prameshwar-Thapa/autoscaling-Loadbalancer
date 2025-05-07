resource "aws_lb" "this" {
  name               = "autoscaling-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets

  tags = {
    Name = "autoscaling-alb"
  }
}

resource "aws_lb_target_group" "this" {
  name     = "autoscaling-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
    path                = "/"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
