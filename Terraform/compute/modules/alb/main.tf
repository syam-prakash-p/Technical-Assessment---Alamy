

resource "aws_lb" "alb" {
  name               =  var.lb_name
  internal           =  var.lb_internal
  load_balancer_type = var.lb_type
  security_groups    = var.security_groups
  subnets            =  var.subnets
  enable_deletion_protection =  var.lb_enable_deletion_protection

  access_logs {
    bucket  = var.lb_access_logs.bucket
    prefix  = var.lb_access_logs.prefix
    enabled = var.lb_access_logs.enabled
  }

  tags = var.tags
}



resource "aws_lb_target_group" "alb_tg" {
  port     =  var.target_group_port
  protocol =  var.target_group_protocol
  target_type = var.target_type
  vpc_id   =  var.vpc_id
}


resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.http_listener_port
  protocol          = var.http_listener_protocol

  default_action {
    type = var.http_default_action

    redirect {
      port        = var.http_redirect_action.port
      protocol    = var.http_redirect_action.protocol
      status_code = var.http_redirect_action.status_code
    }
  }
}

resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.https_listener_port
  protocol          = var.https_listener_protocol
  ssl_policy        = var.https_listener_ssl_policy
  certificate_arn   = var.certificate_arn
  default_action {
    type = var.https_listener_default_action
    target_group_arn = aws_lb_target_group.alb_tg.arn
   
  }
}

# resource "aws_lb_listener_certificate" "example" {
#   listener_arn    = aws_lb_listener.alb_listener.arn
#   certificate_arn = var.certificate_arn
# }

