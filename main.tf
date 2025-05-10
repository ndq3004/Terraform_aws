provider "aws" {
    region = var.aws_region
}

resource "aws_instance" "example" {
  ami = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "App-${var.environment}"
  }
}
