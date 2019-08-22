# If you want to use IAM Roles to provision resources using terraform . For example, cross account IAM roles, you can do it this way.
# There are 2 accounts in this case. One account creates role for cross-account access. The other account uses the role to provision 
# resources. In this case, the access key ID and secret access key belong to Account A while the Role ARN belongs to Account B

provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
  
  # This line adds a role that your account can use to provision resources in another account. Replace the role with a real role ARN in the destination account. 
  assume_role {
  role_arn = " arn:aws:iam::659842330331:user/glhomeuser1"
}
}

resource "aws_instance" "terraform-example" {
  ami           = "ami-0c938c7bf1708407c"
  instance_type = "t2.micro"
  key_name = "homekey"
  security_groups = ["${aws_security_group.allow_rdp.name}"]

}

resource "aws_security_group" "allow_rdp" {
  name        = "allow_rdp"
  description = "Allow ssh traffic"


  ingress {

    from_port   = 3389 #  By default, the windows server listens on TCP port 3389 for RDP
    to_port     = 3389
    protocol =   "tcp"

    cidr_blocks =  ["0.0.0.0/0"]
  }
