provider "aws"{
  region = "ap-southeast-2"
}

resource "aws_instance" "my_example" {
  ami = "ami-09a2f74ce8538e414"
  instance_type = "t3.micro"
  tags = {
    Name = "terraform-example"
  }
}
