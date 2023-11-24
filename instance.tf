#key-pair

#security_group

#instance
resource "aws_instance" "web" {
  ami           = "${var.image_id}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.key_tf.key_name}"
  vpc_security_group_ids = ["${aws_security_group.security.id}"]
  tags = {
    Name = "first-tf-instance"
  }
  user_data = file("${path.module}/script.sh")

  #file,local-exec , remort-exec
  connection {  # bulding connection with the instance 
      type = "ssh"
      user = "ubuntu"
      private_key = file("${path.module}/id_rsa")
      host = "${self.public_ip}"
    } 
   provisioner "file" {
    source = "readme.md"# terraform machine
    destination = "/tmp/readme.md"  # given an temp location  
  }
  # provisioner "local-exec" {
  #   command = "echo ${self.public_ip} > /tmp/mypublicip.txt"
  # } 
  provisioner "local-exec" {
   interpreter = [ "C:/Users/SanjyotDharankar/AppData/Local/Microsoft/WindowsApps/python3.exe",
   "-c" ]
  command = "print('hello world!!')"
  }  
  provisioner "local-exec" {
    working_dir = "/tmp/"
    command = "echo ${self.public_ip} > /tmp/mypubliciip.txt"
  }
 }
