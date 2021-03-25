module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "5.12.0"

  name               = "http-alb"
  load_balancer_type = "application"

  security_groups = [module.external-web.this_security_group_id]
  subnets         = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  vpc_id          = module.vpc.vpc_id

  http_tcp_listeners = [
    {
      port     = 80
      protocol = "HTTP"
    },
  ]

  target_groups = [
    {
      name             = "internal-web"
      backend_port     = 80
      backend_protocol = "HTTP"
      target_type      = "instance"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
# Ugly hack as the default apache splash page sends a 403 http code upsetting the ALB by default
        matcher             = "200-499"
      }
    }
  ]
}

# Module does not support attachment so lets attach
resource "aws_alb_target_group_attachment" "ec2-private-attach" {
  port             = 80
  target_group_arn = module.alb.target_group_arns[0]
  target_id        = module.ec2-private.id[0]
}