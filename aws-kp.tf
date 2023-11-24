resource "aws_key_pair" "key_tf" {
  key_name   = "key_tform"
  public_key = file("${path.module}/id_rsa.pub")
}