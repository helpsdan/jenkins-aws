variable "security_group" {}

variable "public_subnet" {}

data "aws_ami" "ubuntu" {
   most_recent = "true"

   filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
   }

   filter {
      name = "virtualization-type"
      values = ["hvm"]
   }

   owners = ["099720109477"]
}

resource "aws_instance" "jenkins_server" {
   ami = data.aws_ami.ubuntu.id
   subnet_id = var.public_subnet
   instance_type = "t2.micro"
   vpc_security_group_ids = [var.security_group]
   key_name = aws_key_pair.key.key_name
   user_data = "${file("${path.module}/install_jenkins.sh")}"

   tags = {
      Name = "jenkins_server"
   }
}

resource "aws_key_pair" "key" {
   key_name = "key"
   public_key = file("${path.module}/key.pub")
}

resource "aws_eip" "jenkins_eip" {
   instance = aws_instance.jenkins_server.id
   vpc      = true

   tags = {
      Name = "jenkins_eip"
   }
}
