module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"
  depends_on = [
    module.ec2_private_app1,
    module.ec2_private_app2,
    module.ec2_instance_bastion,
    module.vpc
  ]
  name = "${local.name}-alb"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  security_groups = [module.bastion_security_group.security_group_id]
  security_group_rules = {
    ingress_all_http = {
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP web traffic"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress_all_http = {
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "HTTP web traffic"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress_all_icmp = {
      type        = "ingress"
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      description = "ICMP"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  #listener
  http_tcp_listeners = [
    {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      },

    }
  ]
  https_listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = module.acm.acm_certificate_arn
      action_type     = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed Static message - for Root Context"
        status_code  = "200"
      }

  }]


  # HTTPS Listener Rules
  https_listener_rules = [
    # Rule-1: /app1* should go to App1 EC2 Instances
    {
      https_listener_index = 0
      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
      conditions = [{
        path_patterns = ["/app1*"]
      }]
    },
    # Rule-2: /app2* should go to App2 EC2 Instances    
    {
      https_listener_index = 0
      actions = [
        {
          type               = "forward"
          target_group_index = 1
        }
      ]
      conditions = [{
        path_patterns = ["/app2*"]
      }]
      tags = local.common_tags # Target Group Tags

    },
  ]


  #Target_Group


  target_groups = [
    # App1 Target Group - TG Index = 0
    {
      name_prefix          = "app1-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      # App1 Target Group - Targets
      targets = {
        my_app1_vm1 = {
          target_id = module.ec2_private_app1["App1-A"].id
          port      = 80
        },
        my_app1_vm2 = {
          target_id = module.ec2_private_app1["App1-B"].id
          port      = 80
        }
      }
      tags = local.common_tags # Target Group Tags
    },
    # App2 Target Group - TG Index = 1
    {
      name_prefix          = "app2-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app2/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      # App1 Target Group - Targets
      targets = {
        my_app2_vm1 = {
          target_id = module.ec2_private_app2["App2-A"].id
          port      = 80
        },
        my_app2_vm2 = {
          target_id = module.ec2_private_app2["App2-B"].id
          port      = 80
        }
      }
      tags = local.common_tags # Target Group Tags
    }
  ]


  tags = local.common_tags # ALB Tags
}
