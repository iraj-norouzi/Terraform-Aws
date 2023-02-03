resource "aws_key_pair" "IRAJ_KEY" {
  key_name   = "Iraj_Key"
  public_key = var.PUBLIC_KEY

}

resource "aws_instance" "example" {
  for_each               = var.EC2_DEPLOYMENTS
  ami                    = lookup(var.AMIS, each.value.AWS_REGION, "") # last parameter is the default value
  instance_type          = each.value.INSTANCE_TYPE
  key_name               = aws_key_pair.IRAJ_KEY.key_name
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data              = file("script.sh")
  tags = {
    Name = each.key
  }
  depends_on = [
    aws_security_group.sg
  ]
  # provisioner "file" {
  #   source      = "script.sh"
  #   destination = "/tmp/script.sh"
  # }
  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/script.sh",
  #     "sudo sed -i -e 's/\r$//' /tmp/script.sh", # Remove the spurious CR characters.
  #     "sudo /tmp/script.sh",
  #   ]
  # }
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}

