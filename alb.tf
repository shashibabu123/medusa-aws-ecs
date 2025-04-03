resource "aws_lb" "medusa_alb" {
  name               = "medusa-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-04db6af79ee53e8bc"]
  subnets           = ["subnet-08d17c192bd820609", "subnet-034ad409bef42e2d8"]
}

resource "aws_lb_target_group" "medusa_target_group" {
  name     = "medusa-tg"
  port     = 9000
  protocol = "HTTP"
  vpc_id   = "vpc-0403115e598e6492c"
  target_type = "ip"
}

resource "aws_lb_listener" "medusa_listener" {
  load_balancer_arn = aws_lb.medusa_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.medusa_target_group.arn
  }
}

