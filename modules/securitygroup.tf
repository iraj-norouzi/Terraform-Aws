# data "aws_ip_ranges" "european_ec2" {
#   regions  = ["us-east-1"]
#   services = ["ec2"]
# }

# resource "aws_security_group" "from_europe" {
#   name = "from_europe"

#   ingress {
#     from_port   = "443"
#     to_port     = "443"
#     protocol    = "tcp"
#     cidr_blocks = slice(data.aws_ip_ranges.european_ec2.cidr_blocks, 0, 50)
#   }
#   tags = {
#     CreateDate = data.aws_ip_ranges.european_ec2.create_date
#     SyncToken  = data.aws_ip_ranges.european_ec2.sync_token
#   }
# }


resource "aws_security_group" "sg" {
  # egress = [
  #   {
  #     cidr_blocks      = ["0.0.0.0/0", ]
  #     description      = ""
  #     from_port        = 0
  #     ipv6_cidr_blocks = []
  #     prefix_list_ids  = []
  #     protocol         = "-1"
  #     security_groups  = []
  #     self             = false
  #     to_port          = 0
  #   }
  # ]
  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    for_each = local.egress_rules
    content {
      cidr_blocks = ["0.0.0.0/0", ]
      description = ""
      from_port   = egress.value.from_port
      protocol    = egress.value.protocol
      self        = egress.value.self
      to_port     = egress.value.to_port

    }


  }

}


