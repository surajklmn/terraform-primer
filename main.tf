provider "aws"{
  region = "ap-southeast-2"
}

variable "server_port" {
  description = "Server port number"
  type = number
  default = 8080
  
}
resource "aws_instance" "my_example" {
  ami = "ami-09a2f74ce8538e414"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
user_data = <<-EOF
#!/bin/bash
echo "Hello, World!" > index.html
nohup python3 -m http.server ${var.server_port} &
EOF
user_data_replace_on_change = true
tags = {
  Name = "terraform-example"
}
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress  {
    from_port = var.server_port
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
}

output "public_ip"{
  value = aws_instance.my_example.public_ip
  description = "The public ip address of the webserver"
  # sensitive = true this will hide the output shown in terraform apply and terraform output
}
