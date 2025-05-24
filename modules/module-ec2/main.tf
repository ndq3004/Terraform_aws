resource "aws_instance" "ec2_module" {
  ami = var.config.ami
  instance_type = var.config.instance_type
  subnet_id = var.subnet_ids[0]
  tags = {
    Name = "App-${var.config.environment}"
  }
}
