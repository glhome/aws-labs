resource "aws_instance" "win-example" {
  ami           = "ami-0c938c7bf1708407c"
  instance_type = "t2.micro"
  key_name = "homekey"
  security_groups = ["${aws_security_group.allow_rdp.name}"]

}
