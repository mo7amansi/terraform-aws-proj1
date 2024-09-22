resource "aws_lb" "proj1_alb" {
  name               = "proj1_ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.pub_sub1.id, aws_subnet.pub_sub2.id]

  enable_deletion_protection = false


  tags = {
    Environment = "proj1_ALB"
  }
}

# Target Group
resource "aws_lb_target_group" "proj1_tg" {
  name        = "proj1-TG"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.proj1_vpc.id

  health_check {
    protocol = "HTTP"
    path     = "/"
  }

  tags = {
    Name = "proj1_TG"
  }
}

# Listener for ALB
resource "aws_lb_listener" "proj1_listener" {
  load_balancer_arn = aws_lb.proj1_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.proj1_tg.arn
  }
}