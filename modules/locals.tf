locals {
  ingress_rules = [{
    port        = 443
    description = "Ingress rules for port 443"
    },
    {
      port        = 22
      description = "Ingree rules for port 22"
    },
    {
      port        = 80
      description = "Ingree rules for port 80"
  }]
}
locals {
  egress_rules = [{
    port     = 0
    protocol = "-1"
    cidr_blocks      = ["0.0.0.0/0", ]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    self             = false
    to_port          = 0

    }
  ]
}
