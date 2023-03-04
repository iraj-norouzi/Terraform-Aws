resource "aws_key_pair" "IRAJ_KEY" {
  key_name   = "Iraj_Key"
  public_key = var.PUBLIC_KEY

}
