provider "aws" {
  #access_key = ""
  #secret_key = ""
  region     = "us-east-1"
}


resource "aws_instance" "example" {
  ami           = "ami-0c938c7bf1708407c"
  instance_type = "t2.micro"
  key_name = "homekey"
  security_groups = ["${aws_security_group.allow_rdp.name}"]

}


resource "aws_security_group" "allow_rdp" {
  name        = "allow_rdp"
  description = "Allow rdp traffic"


  ingress {

    from_port   = 3389 #  By default, the windows server listens on TCP port 3389 for RDP
    to_port     = 3389
    protocol =   "tcp"

    cidr_blocks =  ["0.0.0.0/0"]
  }
}

